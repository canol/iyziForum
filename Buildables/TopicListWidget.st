Iliad.ILWidget subclass: TopicListWidget [
	| topics pagerWidget |
	
	<category: 'IyziForum-Buildables'>
	<comment: nil>
	
	initialize [
		<category: 'initialization'>
		
		super initialize.
		
		self topics: OrderedCollection new.
		self pagerWidget: (PagerWidget new
			targetWidget: self;
			elementCountPerPage: self application settingList topicsPerPage).
	]
	
	topics [
		| topics |
		
		<category: 'accessing'>
		
		topics := self application postRepository posts select: [:each | each parentPost = nil].
		topics := topics asSortedCollection: [:topic1 :topic2 |
			| date1 date2 |
			
			(topic1 lastReply isNil)
				ifTrue: [
					date1 := topic1 dateTime]
				ifFalse: [
					date1 := topic1 lastReply dateTime].
					
			(topic2 lastReply isNil)
				ifTrue: [
					date2 := topic2 dateTime]
				ifFalse: [
					date2 := topic2 lastReply dateTime].
			
			date1 > date2].
		
		^topics
	]
	
	topics: anOrderedCollection [
		<category: 'accessing'>
		
		topics := anOrderedCollection.
		self markDirty.
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
		
		^self topics
	]
	
	elements: anOrderedCollection [
		<category: 'accessing'>
		
		self topics: anOrderedCollection.
	]
	
	contents [
		<category: 'building'>
	
		^[:e |
			e table
				class: 'TopicList';
				cellspacing: self application settingList tableCellSpacings;
				build: [:table || index |
					table tr build: [:tr |
						tr th
							class: 'ReadUnread';
							style: 'width: 4%';
							space.
						tr th
							class: 'Subject';
							style: 'width: 55%';
							text: 'Subject'.
						tr th
							class: 'ReplyCount';
							style: 'width: 7%; text-align: center';
							text: 'Reply'.
						tr th
							class: 'LastReply';
							style: 'width: 34%';
							text: 'Last Reply'].
					
					(self application memberRepository members size = 0)
						ifTrue: [
							table tr td
								class: 'Dark1';
								style: 'height: 150px; text-align: center';
								colspan: 4;
								text: (self application translate: 'There are no members registered on this forum. Please register the first member -who will become an admin of the forum- via the menu above.')]
						ifFalse: [
							(self topics size = 0)
								ifTrue: [
									table tr td
										class: 'Dark1';
										style: 'height: 150px; text-align: center';
										colspan: 4;
										text: (self application translate: 'There are no topics yet.')]].
					
					index := 1.
					self pagerWidget elements do: [:topic |
						| replies lastReplyText |
						
						replies := self application postRepository posts select: [:post | post parentPost = topic].
						
						table tr build: [:tr || class |
							(index \\ 2 = 1)
								ifTrue: [
									class := 'Dark']
								ifFalse: [
									class := 'Light'].
							
							tr td
								class: ('ReadUnread ', class, '1');
								style: 'text-align: center';
								build: [:td |
									((topic membersWhoReadAllTheMessages includes: self application user) or: [self application user loggedIn = false])
										ifTrue: [
											td img
												src: (self application settingList publicFolderUrl, '/skins/', self application settingList defaultSkinName, '/images/no_new_post.gif');
												alt: (self application translate: 'No New Post');
												title: (self application translate: 'No New Post')]
										ifFalse: [
											td img
												src: (self application settingList publicFolderUrl, '/skins/', self application settingList defaultSkinName, '/images/new_post.gif');
												alt: (self application translate: 'New Post');
												title: (self application translate: 'New Post')]].
										
							tr td
								class: ('Subject ', class, '2');
								build: [:td |
									td a
										linkToLocal: ('topic/', (self application postRepository posts indexOf: topic) printString);
										text: topic subject.
									td br.
									td span
										class: 'Small';
										text: topic member memberName].
										
							tr td
								class: ('ReplyCount ', class, '1');
								style: 'text-align: center';
								text: replies size printString.
								
							tr td
								class: ('LastReply ', class, '2');
								build: [:td |
									(replies size > 0)
										ifTrue: [
											| lastReply |
											
											lastReply := replies last.
											
											td b: lastReply member memberName.
											td br.
											td span
												class: 'Small';
												text: (lastReply dateTime printFormatted: self application settingList defaultDateFormat withTimeFormat: self application settingList defaultTimeFormat language: self application settingList defaultLanguage)]
										ifFalse: [
											td text: (self application translate: 'No Reply Yet')]]].
						
						index := index + 1]].
						
			e build: self pagerWidget].
	]
	
	switchToPageNumber: aPositiveInteger [
		<category: 'actions'>
		
		(aPositiveInteger < 2 or: [aPositiveInteger > self pagerWidget pageCount])
			ifTrue: [
				self application redirectToApplication: self application class]
			ifFalse: [
				self application redirectToLocal: aPositiveInteger printString].
	]
]
