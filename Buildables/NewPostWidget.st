FormOnMenuWidget subclass: NewPostWidget [
	| newPost |
	
	<category: 'IyziForum-Buildables'>
	<comment: nil>
	
	initialize [
		<category: 'initialization'>
		
		super initialize.
		
		self newPost: Post new.
	]
	
	contents [
		<category: 'building'>
		
		^[:e |
			e form
				build: [:form |
					form div
						id: 'PostMessageTop';
						class: 'PostMessage';
						style: 'display: none';
						build: [:div |
							| subject |
							
							(self newPost parentPost isNil)
								ifTrue: [
									subject := '']
								ifFalse: [
									subject := (self application translate: 'Re: {Subject}') copyReplaceAll: '{Subject}' with: self newPost parentPost subject].
							
							subject := subject contractTo: self application settingList maxSubjectCharacterCount.
							
							div text: 'Subject:'.
							div br.
							
							div input
								type: 'text';
								maxlength: self application settingList maxSubjectCharacterCount;
								value: subject;
								action: [:subject | self newPost subject: subject].
							div br.
							
							div text: 'Message:'.
							div br.
							
							div textarea
								rows: '12';
								action: [:message | self newPost message: message].
							div br.
							
							div button
								text: (self application translate: 'Send');
								action: [self addNewPost]]]]
	]
	
	addNewPost [
		<category: 'actions'>
		
		| errorDialogWidget |
		
		errorDialogWidget := DialogWidget new.
		errorDialogWidget addButton: DialogAnswerTypes okay.
		
		(self newPost subject = '')
			ifTrue: [
				errorDialogWidget addMessage: (self application translate: 'You cannot leave the subject empty.')]
			ifFalse: [
				(self application settingList minSubjectCharacterCount ~= -1)
					ifTrue: [
						(self newPost subject size < self application settingList minSubjectCharacterCount)
							ifTrue: [
								| errorMessage |
								
								errorMessage := (self application translate: 'The subject cannot be shorter than {MinSubjectCharacterCount} characters.') copyReplaceAll: '{MinSubjectCharacterCount}' with: self application settingList minSubjectCharacterCount printString.
								
								errorDialogWidget addMessage: errorMessage]].

				(self application settingList maxSubjectCharacterCount ~= -1)
					ifTrue: [
						(self newPost subject size > self application settingList maxSubjectCharacterCount)
							ifTrue: [
								| errorMessage |
								
								errorMessage := (self application translate: 'The subject cannot be longer than {MaxSubjectCharacterCount} characters.') copyReplaceAll: '{MaxSubjectCharacterCount}' with: self application settingList maxSubjectCharacterCount printString.
								
								errorDialogWidget addMessage: errorMessage]]].
		
		(self newPost message = '')
			ifTrue: [
				errorDialogWidget addMessage: (self application translate: 'You cannot leave the message empty.')]
			ifFalse: [
				(self application settingList minMessageCharacterCount ~= -1)
					ifTrue: [
						(self newPost message size < self application settingList minMessageCharacterCount)
							ifTrue: [
								| errorMessage |
								
								errorMessage := (self application translate: 'The message cannot be shorter than {MinMessageCharacterCount} characters.') copyReplaceAll: '{MinMessageCharacterCount}' with: self application settingList minMessageCharacterCount printString.
								
								errorDialogWidget addMessage: errorMessage]].

				(self application settingList maxMessageCharacterCount ~= -1)
					ifTrue: [
						(self newPost message size > self application settingList maxMessageCharacterCount)
							ifTrue: [
								| errorMessage |
								
								errorMessage := (self application translate: 'The message cannot be longer than {MaxMessageCharacterCount} characters.') copyReplaceAll: '{MaxMessageCharacterCount}' with: self application settingList maxMessageCharacterCount printString.
								
								errorDialogWidget addMessage: errorMessage]]].
		
		(errorDialogWidget messages size > 0)
			ifTrue: [
				self lightbox: errorDialogWidget]
			ifFalse: [
				| parentPost |
				
				parentPost := self newPost parentPost.
				
				self newPost member: self application user.
				self newPost dateTime: DateTime now.
				self newPost membersWhoReadAllTheMessages add: self application user.
				self newPost ip: self application user ip.
				
				self application postRepository addPost: self newPost.
				(parentPost isNil)
					ifFalse: [
						parentPost lastReply: self newPost].
				self newPost: Post new.
				self newPost parentPost: parentPost.
				
				self application menuWidget markDirty.
				self application topicListWidget markDirty.
				self application postListWidget markDirty].
	]
	
	newPost [
		<category: 'accessing'>
		
		^newPost.
	]
	
	newPost: aPost [
		<category: 'accessing'>
		
		newPost := aPost.
	]
]
