Iliad.ILWidget subclass: MenuWidget [
	| mode loginWidget newPostWidget registerWidget |
	
	<category: 'IyziForum-Buildables'>
	<comment: nil>
	
	initialize [
		<category: 'initialization'>
		
		super initialize.
		
		self loginWidget: LoginWidget new.
		self newPostWidget: NewPostWidget new.
		self registerWidget: RegisterWidget new.
		
		self beNeutralMode.
	]
	
	loginWidget [
		<category: 'accessing'>
		
		^loginWidget
	]
	
	loginWidget: aLoginWidget [
		<category: 'accessing'>
		
		loginWidget := aLoginWidget.
	]
	
	newPostWidget [
		<category: 'accessing'>
		
		^newPostWidget
	]
	
	newPostWidget: aNewPostWidget [
		<category: 'accessing'>
		
		newPostWidget := aNewPostWidget.
	]
	
	registerWidget [
		<category: 'accessing'>
		
		^registerWidget
	]
	
	registerWidget: aRegisterWidget [
		<category: 'accessing'>
		
		registerWidget := aRegisterWidget.
	]
	
	mode [
		<category: 'accessing'>
		
		^mode
	]
	
	mode: aMenuWidgetMode [
		<category: 'accessing'>
		
		mode := aMenuWidgetMode.
	]
	
	beNeutralMode [
		<category: 'actions'>
		
		self mode: MenuWidgetModes neutralMode.
	]
	
	beTopicMode [
		<category: 'actions'>
		
		self mode: MenuWidgetModes topicMode.
		self newPostWidget newPost parentPost: nil.
	]
	
	beReplyMode: aPost [
		<category: 'actions'>
		
		self mode: MenuWidgetModes replyMode.
		self newPostWidget newPost parentPost: aPost.
	]
	
	contents [
		<category: 'building'>
		
		^[:e |
			e div
				class: 'Menu';
				build: self welcomeMessageContents;
				build: self linkContents.
			
			e build: self loginWidget.
			e build: self registerWidget.
			e build: self newPostWidget.
		]
	]
	
	linkContents [
		^[:e |
			self application user loggedIn
				ifTrue: [
					(self mode = MenuWidgetModes topicMode)
						ifTrue: [
							e a
								onClick: 'jQuery(''div#LoginTop'').slideUp(''fast''); jQuery(''div#RegistrationTop'').slideUp(''fast''); jQuery(''div#PostMessageTop'').slideToggle(''fast'')';
								build: [:a |
									a img
										src: self application settingList publicFolderUrl, '/skins/', self application settingList defaultSkinName, '/images/post_new_topic.gif';
										alt: (self application translate: 'Post New Topic').
										
									a space.
										
									a b text: (self application translate: 'Post New Topic')]].
					
					(self mode = MenuWidgetModes replyMode)
						ifTrue: [
							e a
								onClick: 'jQuery(''div#LoginTop'').slideUp(''fast''); jQuery(''div#RegistrationTop'').slideUp(''fast''); jQuery(''div#PostMessageTop'').slideToggle(''fast'')';
								build: [:a |
									a img
										src: self application settingList publicFolderUrl, '/skins/', self application settingList defaultSkinName, '/images/reply.gif';
										alt: (self application translate: 'Reply').
									
									a space.
									
									a b text: (self application translate: 'Reply')]]]
				ifFalse: [
					(self application memberRepository members size > 0)
						ifTrue: [
							e a
								onClick: 'jQuery(''div#PostMessageTop'').slideUp(''fast''); jQuery(''div#RegistrationTop'').slideUp(''fast''); jQuery(''div#LoginTop'').slideToggle(''fast'')';
								"action: [self toggleVisibilityOfLoginWidget];"
								build: [:a |
									a b text: (self application translate: 'Login')]].
			
					e a
						onClick: 'jQuery(''div#PostMessageTop'').slideUp(''fast''); jQuery(''div#LoginTop'').slideUp(''fast''); jQuery(''div#RegistrationTop'').slideToggle(''fast'')';
						"action: [self toggleVisibilityOfRegisterWidget];"
						build: [:a |
							a b text: (self application translate: 'Register')]].
				
				e a
					action: [self application redirectToLocal: 'members'];
					text: (self application translate: 'Members').
				
				self application user loggedIn
					ifTrue: [
						e a
							action: [self application redirectToLocal: 'member/', (self application memberRepository members indexOf: self application user) printString, '/edit'];
							text: (self application translate: 'My Details').
							
						e a
							text: (self application translate: 'Logout');
							action: [
								| dialogWidget |
								
								dialogWidget := DialogWidget new.
								dialogWidget addButton: DialogAnswerTypes no.
								dialogWidget addButton: DialogAnswerTypes yes.
								dialogWidget addMessage: (self application translate: 'Are you sure you want to log out?').
								
								self
									lightbox: dialogWidget
									onAnswer: [:answer |
										(answer = DialogAnswerTypes yes)
											ifTrue: [
												self application logout]]].
						
						(self application settingList admins includes: self application user)
							ifTrue: [
								e a
									href: '#';
									text: (self application translate: 'Admin Panel')]]].
	]
	
	welcomeMessageContents [
		^[:e |
			self application user loggedIn
				ifTrue: [
					e
						text: 'Welcome '.
						
					e b text: self application user memberName]
				ifFalse: [
					e text: (self application translate: 'Welcome visitor!')].
		
			e br]
	]
]
