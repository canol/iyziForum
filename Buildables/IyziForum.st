Iliad.ILApplication subclass: IyziForum [
	| user title languageRepository memberRepository postRepository settingList
	menuWidget navigationWidget topicListWidget postListWidget memberListWidget memberDetailsWidget editMemberDetailsWidget |
	
	<category: 'IyziForum-Buildables'>
	<comment: nil>
	
	IyziForum class >> path [
		<category: 'accessing'>
		
		^'forum'
	]
	
	IyziForum class >> version [
		<category: 'accessing'>
		
		^'0.1'
	]
	
	initialize [
		<category: 'initialization'>
		
		super initialize.
		
		self languageRepository: LanguageRepository default.
		self memberRepository: MemberRepository default.
		self postRepository: PostRepository default.
		self settingList: SettingList default.
		
		self settingList defaultLanguage: self languageRepository defaultLanguage.
		
		self title: self settingList forumTitle.
	]
	
	dispatchOverride [
		<category: 'dispatching'>
		
		(self router controller isNil)
			ifFalse: [
				(self router controller asInteger ~= 0)
					ifTrue: [
						^self dispatchOn: 'index']].
						
		^super dispatchOverride
    ]
	
	updatePage: aPage [
		<category: 'building'>
		
		super updatePage: aPage.
		
		((self request cookies includesKey: 'MemberName') and: [self request cookies includesKey: 'Password'])
			ifTrue: [
				| cookieMemberName cookiePassword members |
				
				cookieMemberName := self request cookies at: 'MemberName'.
				cookiePassword := self request cookies at: 'Password'.
				
				members := self memberRepository members select: [:member | member memberName = cookieMemberName and: [member password = cookiePassword]].
				
				(members isEmpty not)
					ifTrue: [
						self user: (members at: 1)]].
						
		aPage head stylesheet href: self settingList publicFolderUrl, '/skins/', self settingList defaultSkinName, '/stylesheets/main.css'.
		aPage head title: self title.
	]
	
	index [
		| pageNumber |
		
		<category: 'controllers'>
		
		self title: self settingList forumTitle.
		
		pageNumber := 1.
		(self router controller isNil)
			ifFalse: [
				(self router controller asInteger = 0)
					ifFalse: [
						pageNumber := self router controller asInteger.
						
						(pageNumber = 0)
							ifTrue: [
								pageNumber := 1]]].
		
		self menuWidget beTopicMode.
		self topicListWidget pagerWidget currentPageNumber: pageNumber.
		
		^self mainPageContents
	]
	
	topic [
		<category: 'controllers'>
		
		(self router route atEnd)
			ifTrue: [
				^self index]
			ifFalse: [
				| topicPostId topicPost pageNumber |
				
				topicPostId := self router route next.
				topicPost := self postRepository posts at: topicPostId asInteger.
				
				(self router route atEnd)
					ifTrue: [
						pageNumber := 1]
					ifFalse: [
						pageNumber := self router route next asInteger].
				
				self title: topicPost subject, ' - ', self settingList forumTitle.
				
				self navigationWidget
					clear;
					addText: topicPost subject.
				
				self menuWidget beReplyMode: topicPost.
				
				self postListWidget mainPost: topicPost.
				self postListWidget pagerWidget currentPageNumber: pageNumber.
				
				self user loggedIn
					ifTrue: [
						topicPost membersWhoReadAllTheMessages add: self user].
				
				^self topicsPageContents]
	]
	
	members [
		| pageNumber |
		
		<category: 'controllers'>
		
		(self router route atEnd)
			ifTrue: [
				pageNumber := 1]
			ifFalse: [
				pageNumber := self router route next asInteger].
		
		self title: self settingList forumTitle, ' - ', (self translate: 'Members').
		
		self navigationWidget
			clear;
			addText: (self translate: 'Members').
			
		self menuWidget beNeutralMode.
		
		self memberListWidget pagerWidget currentPageNumber: pageNumber.
		
		^self membersPageContents
	]
	
	member [
		<category: 'controllers'>
		
		(self router route atEnd)
			ifTrue: [
				^self index]
			ifFalse: [
				| memberId member |
				
				memberId := self router route next.
				member := self memberRepository members at: memberId asInteger.
				
				self menuWidget beNeutralMode.
				(self router route atEnd)
					ifTrue: [
						self navigationWidget
							clear;
							addUrl: 'members' text: (self translate: 'Members');
							addText: member memberName.
						
						self title: self settingList forumTitle, ' - ', (self translate: 'Member Details').
						
						self memberDetailsWidget member: member.
						
						^self memberDetailsPageContents]
					ifFalse: [
						self navigationWidget
							clear;
							addUrl: 'members' text: (self translate: 'Members');
							addUrl: ('member/', (self application memberRepository members indexOf: member) printString) text: member memberName;
							addText: (self translate: 'Edit Member Details').
						
						self title: self settingList forumTitle, ' - ', (self translate: 'Edit Member Details').
						
						self editMemberDetailsWidget member: member.
						
						^self editMemberDetailsPageContents]]
	]
	
	footerContents [
		<category: 'building'>
		
		^[:e |
			e div
				class: 'Footer';
					build: [:div |
					div a
						href: self settingList webSiteUrl;
						text: self settingList webSiteName.
			
					div
						space;
						text: '|';
						space.
			
					div a
						href: 'mailto:', self settingList emailAddress;
						text: (self translate: 'Email').
						
					div br.
					
					div span
						class: 'Small';
						build: [:span |
							span a
								href: 'http://www.iyziforum.com';
								text: 'iyzi Forum ', self version]]]
	]
	
	headerContents [
		<category: 'building'>
		
		^[:e |
			e div
				class: 'Logo';
				build: [:div |
					div a
						linkToApplication: self class;
						text: self settingList forumName.
					
					"div a
						class: 'Image';
						linkToApplication: self class;
						build: [:a |
							a img
								src: (self settingList publicFolderUrl, '/skins/', self settingList defaultSkinName, '/images/logo.png');
								alt: self settingList forumName]"]].
	]
	
	mainPageContents [
		<category: 'building'>
		
		^[:e |
			e div
				class: 'MainWrapper';
				build: self headerContents;
				build: self menuWidget;
				build: self topicListWidget;
				build: self footerContents]
	]
	
	topicsPageContents [
		<category: 'building'>
		
		^[:e |
			e div
				class: 'MainWrapper';
				build: self headerContents;
				build: self menuWidget;
				build: self application navigationWidget;
				build: self postListWidget;
				build: self application navigationWidget;
				build: self footerContents]
	]
	
	membersPageContents [
		<category: 'building'>
			
		^[:e |
			e div
				class: 'MainWrapper';
				build: self headerContents;
				build: self menuWidget;
				build: self application navigationWidget;
				build: self memberListWidget;
				build: self application navigationWidget;
				build: self footerContents]
	]
	
	memberDetailsPageContents [
		<category: 'building'>
			
		^[:e |
			e div
				class: 'MainWrapper';
				build: self headerContents;
				build: self menuWidget;
				build: self application navigationWidget;
				build: self memberDetailsWidget;
				build: self application navigationWidget;
				build: self footerContents]
	]
	
	editMemberDetailsPageContents [
		<category: 'building'>
			
		^[:e |
			e div
				class: 'MainWrapper';
				build: self headerContents;
				build: self menuWidget;
				build: self application navigationWidget;
				build: self editMemberDetailsWidget;
				build: self application navigationWidget;
				build: self footerContents]
	]
	
	menuWidget [
		<category: 'accessing'>
		
		^menuWidget ifNil: [menuWidget := MenuWidget new]
	]
	
	menuWidget: aMenuWidget [
		<category: 'accessing'>
		
		menuWidget := aMenuWidget.
	]
	
	navigationWidget [
		<category: 'accessing'>
		
		^navigationWidget ifNil: [navigationWidget := NavigationWidget new]
	]
	
	navigationWidget: aNavigationWidget [
		<category: 'accessing'>
		
		navigationWidget := aNavigationWidget.
	]
	
	topicListWidget [
		<category: 'accessing'>
		
		^topicListWidget ifNil: [topicListWidget := TopicListWidget new]
	]
	
	topicListWidget: aTopicListWidget [
		<category: 'accessing'>
		
		topicListWidget := aTopicListWidget.
	]
	
	postListWidget [
		<category: 'accessing'>
		
		^postListWidget ifNil: [postListWidget := PostListWidget new]
	]
	
	postListWidget: aPostListWidget [
		<category: 'accessing'>
		
		postListWidget := aPostListWidget.
	]
	
	memberListWidget [
		<category: 'accessing'>
		
		^memberListWidget ifNil: [memberListWidget := MemberListWidget new]
	]
	
	memberListWidget: aMemberListWidget [
		<category: 'accessing'>
		
		memberListWidget := aMemberListWidget.
	]
	
	memberDetailsWidget [
		<category: 'accessing'>
		
		^memberDetailsWidget ifNil: [memberDetailsWidget := MemberDetailsWidget new]
	]
	
	memberDetailsWidget: aMemberDetailsWidget [
		<category: 'accessing'>
		
		memberDetailsWidget := aMemberDetailsWidget.
	]
	
	editMemberDetailsWidget [
		<category: 'accessing'>
		
		^editMemberDetailsWidget ifNil: [editMemberDetailsWidget := EditMemberDetailsWidget new]
	]
	
	editMemberDetailsWidget: anEditMemberDetailsWidget [
		<category: 'accessing'>
		
		editMemberDetailsWidget := anEditMemberDetailsWidget.
	]
	
	memberRepository [
		<category: 'accessing'>
		
		^memberRepository
	]
	
	memberRepository: aMemberRepository [
		<category: 'accessing'>
		
		memberRepository := aMemberRepository.
	]
	
	languageRepository [
		<category: 'accessing'>
		
		^languageRepository
	]
	
	languageRepository: aLanguageRepository [
		<category: 'accessing'>
		
		languageRepository := aLanguageRepository.
	]
	
	postRepository [
		<category: 'accessing'>
		
		^postRepository
	]
	
	postRepository: aPostRepository [
		<category: 'accessing'>
		
		postRepository := aPostRepository.
	]
	
	settingList [
		<category: 'accessing'>
		
		^settingList
	]
	
	settingList: aSettingList [
		<category: 'accessing'>
		
		settingList := aSettingList.
	]
	
	title [
		<category: 'accessing'>
		
		^title
	]
	
	title: aString [
		<category: 'accessing'>
		
		title := aString.
	]
	
	user [
		<category: 'accessing'>
		
		^user ifNil: [user := Guest new]
	]
	
	user: aUser [
		<category: 'accessing'>
		
		user := aUser
	]
	
	version [
		<category: 'accessing'>
		
		^IyziForum version
	]
	
	respondOn: aResponse [
		<category: 'converting'>
		
		self user ip: self request nativeRequest ip hostAddressString.
		
		self user loggedIn ifTrue: [
			self user lastPresenceDateTime: DateTime now.
			
			self user remember ifTrue: [
				| cookie |
				
				cookie := Iliad.ILCookie key: 'MemberName' value: self user memberName.
				cookie expireIn: (Duration days: 365).
				aResponse addCookie: cookie.
				
				cookie := Iliad.ILCookie key: 'Password' value: self user password.
				cookie expireIn: (Duration days: 365).
				aResponse addCookie: cookie].
			
			(self user status = MemberStatuses deleted)
				ifTrue: [self logout]].

		super respondOn: aResponse.
	]
	
	translate: aString [
		<category: 'actions'>
		
		^self settingList defaultLanguage translate: aString
	]
	
	logout [
		<category: 'actions'>
		
		self user: Guest new.
		self menuWidget markDirty.
		self memberDetailsWidget markDirty.
		self editMemberDetailsWidget markDirty.
		self application postListWidget markDirty.
	]
	
	deleteMember: aMember [
		<category: 'actions'>
		
		aMember status: MemberStatuses deleted.
	]
	
	isAdmin: aMember [
		<category: 'testing'>
		
		^self settingList admins includes: aMember
	]
	
	isModerator: aMember [
		<category: 'testing'>
		
		^self settingList moderators includes: aMember
	]
	
	isBoardMember: aMember [
		<category: 'testing'>
		
		^(self isAdmin: aMember) or: [self isModerator: aMember]
	]
]
