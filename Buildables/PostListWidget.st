Iliad.ILWidget subclass: PostListWidget [
	| mainPost posts pagerWidget |
	
	<category: 'IyziForum-Buildables'>
	<comment: nil>
	
	initialize [
		<category: 'initialization'>
		
		super initialize.
		
		self posts: OrderedCollection new.
		self pagerWidget: (PagerWidget new
			targetWidget: self;
			elementCountPerPage: self application settingList postsPerPage).
	]
	
	mainPost [
		<category: 'accessing'>
		
		^mainPost.
	]
	
	mainPost: aPost [
		<category: 'accessing'>
		
		mainPost := aPost.
	]
	
	posts [
		<category: 'accessing'>
		
		posts := self application postRepository posts select: [:each | each parentPost = self mainPost].
		posts add: mainPost.
		posts := posts asSortedCollection: [:post1 :post2 | post2 dateTime > post1 dateTime].
		
		^posts
	]
	
	posts: anOrderedCollection [
		<category: 'accessing'>
		
		posts := anOrderedCollection.
	]
	
	pagerWidget [
		<category: 'accessing'>
		
		^pagerWidget
	]
	
	pagerWidget: aPagerWidget [
		<category: 'accessing'>
		
		pagerWidget := aPagerWidget.
	]
	
	elements [
		<category: 'accessing'>
		
		^self posts
	]
	
	elements: anOrderedCollection [
		<category: 'accessing'>
		
		self posts: anOrderedCollection.
	]
	
	contents [
		<category: 'building'>
		
		^[:e |
			| index |
			
			e build: self pagerWidget.
			
			index := 1.
			
			self pagerWidget elements do: [:post |
				| postBodyWidget additionalClass |
				
				postBodyWidget := PostBodyWidget new
					post: post;
					yourself.
				
				(index \\ 2 = 1)
					ifTrue: [
						additionalClass := 'Light']
					ifFalse: [
						additionalClass := 'Dark'].
						
				e div
					class: 'Post ', additionalClass;
					build: [:div |
						div table
							cellspacing: 0;
							class: 'Information ', additionalClass;
							build: [:table |
								table tr
									build: [:tr |
										tr td
											build: [:td |
												| memberID |
												
												memberID := self application memberRepository members indexOf: post member.
												td a
													linkToLocal: ('member/', memberID printString);
													text: post member memberName.
													
												(self application isAdmin: post member)
													ifTrue: [
														td span
															class: 'Small';
															text: ' (', (self application translate: 'Admin'), ')'].
												
												(self application isModerator: post member)
													ifTrue: [
														td span
															class: 'Small';
															text: ' (', (self application translate: 'Moderator'), ')'].
												
												(post member status = MemberStatuses deleted)
													ifTrue: [
														td span
															class: 'Small';
															text: ' (', (self application translate: 'Membership Deleted'), ')']].
										tr td
											build: [:td |
												td
													style: 'text-align: right';
													build: [:tdDate |
														tdDate span
															class: 'Small';
															text: (post dateTime printFormatted: self application settingList defaultDateFormat withTimeFormat: self application settingList defaultTimeFormat language: self application settingList defaultLanguage)]]]].

						div div
							class: 'Subject';
							build: [:divPostSubject |
								divPostSubject h1: post subject].
						
						div build: postBodyWidget].
								
				index := index + 1].
				
		e build: self pagerWidget]
	]
	
	switchToPageNumber: aPositiveInteger [
		<category: 'actions'>
		
		(aPositiveInteger < 2 or: [aPositiveInteger > self pagerWidget pageCount])
			ifTrue: [
				self application redirectToLocal: ('topic/', (mainPost id: self application postRepository posts) printString)]
			ifFalse: [
				self application redirectToLocal: ('topic/', (mainPost id: self application postRepository posts) printString, '/', aPositiveInteger printString)].
	]
]
