FormOnMenuWidget subclass: RegisterWidget [
	| memberName password1 password2 emailAddress hideEmail |
	
	<category: 'IyziForum-Buildables'>
	<comment: nil>
	
	initialize [
		<category: 'initialization'>
		
		super initialize.
		
		self memberName: ''.
		self password1: ''.
		self password2: ''.
		self emailAddress: ''.
		self hideEmail: false.
	]
	
	contents [
		<category: 'building'>
		
		^[:e |
			e form
				build: [:form |
					form div
						id: 'RegistrationTop';
						class: 'Registration';
						style: 'display: none';
						build: [:div |
							div text: (self application translate: 'Member Name:').
							div br.
							
							div input
								maxlength: self application settingList maxMemberNameCharacterCount;
								action: [:memberName | self memberName: memberName].
							div text: '*'.
							div br.
							
							div text: (self application translate: 'Password:').
							div br.
							
							div input
								type: 'password';
								maxlength: '255';
								action: [:password1 | self password1: password1].
							div text: '*'.
							div br.
							
							div text: (self application translate: 'Password Again:').
							div br.
							
							div input
								type: 'password';
								maxlength: '255';
								action: [:password2 | self password2: password2].
							div text: '*'.
							div br.
													
							(self application settingList shouldMembersEnterEmail)
								ifTrue: [							
									div text: (self application translate: 'Email'), ':'.
									div br.
									
									div input
										maxlength: '255';
										action: [:emailAddress | self emailAddress: emailAddress].
									div text: '*'.
									div br].
							
							div button
								text: (self application translate: 'Register');
								action: [self register]]]]
	]
	
	emailAddress [
		<category: 'accessing'>
		
		^emailAddress
	]
	
	emailAddress: aString [
		<category: 'accessing'>
		
		emailAddress := aString.
	]
	
	hideEmail [
		<category: 'accessing'>
		
		^hideEmail
	]
	
	hideEmail: aBoolean [
		<category: 'accessing'>
		
		hideEmail := aBoolean.
	]
	
	memberName [
		<category: 'accessing'>
		
		^memberName
	]
	
	memberName: aString [
		<category: 'accessing'>
		
		memberName := aString.
	]
	
	password1 [
		<category: 'accessing'>
		
		^password1
	]
	
	password1: aString [
		<category: 'accessing'>
		
		password1 := aString.
	]
	
	password2 [
		<category: 'accessing'>
		
		^password2
	]
	
	password2: aString [
		<category: 'accessing'>
		
		password2 := aString.
	]
	
	register [
		| member errorDialogWidget |
		
		errorDialogWidget := DialogWidget new.
		errorDialogWidget addButton: DialogAnswerTypes okay.
		
		(self memberName = '')
			ifTrue: [
				errorDialogWidget addMessage: (self application translate: 'You cannot leave the member name empty.')]
			ifFalse: [
				(self application settingList minMemberNameCharacterCount ~= -1)
					ifTrue: [
						(self memberName size < self application settingList minMemberNameCharacterCount)
							ifTrue: [
								| errorMessage |
								
								errorMessage := (self application translate: 'The member name cannot be shorter than {MinMemberNameCharacterCount} characters.') copyReplaceAll: '{MinMemberNameCharacterCount}' with: self application settingList minMemberNameCharacterCount printString.
								
								errorDialogWidget addMessage: errorMessage]].
									
				(self application settingList maxMemberNameCharacterCount ~= -1)
					ifTrue: [
						(self memberName size > self application settingList maxMemberNameCharacterCount)
							ifTrue: [
								| errorMessage |
								
								errorMessage := (self application translate: 'The member name cannot be longer than {MaxMemberNameCharacterCount} characters.') copyReplaceAll: '{MaxMemberNameCharacterCount}' with: self application settingList maxMemberNameCharacterCount printString.
								
								errorDialogWidget addMessage: errorMessage]]].

		
		((self application memberRepository members select: [:each | each memberName = self memberName]) size > 0)
			ifTrue: [
				errorDialogWidget addMessage: (self application translate: 'The member name you have chosen has already been registered. Please choose another member name.')].
		
		(self password1 = '')
			ifTrue: [
				errorDialogWidget addMessage: (self application translate: 'You cannot leave the password empty.')]
			ifFalse: [
				(self application settingList minPasswordCharacterCount ~= -1)
					ifTrue: [
						(self password1 size < self application settingList minPasswordCharacterCount)
							ifTrue: [
								| errorMessage |
								
								errorMessage := (self application translate: 'The password cannot be shorter than {MinPasswordCharacterCount} characters.') copyReplaceAll: '{MinPasswordCharacterCount}' with: self application settingList minPasswordCharacterCount printString.
								
								errorDialogWidget addMessage: errorMessage]]].

		(self password2 = '')
			ifTrue: [
				errorDialogWidget addMessage: (self application translate: 'Please don''t forget to fill in the password twice.')].
		
		(self password1 = self password2)
			ifFalse: [
				errorDialogWidget addMessage: (self application translate: 'The passwords you entered do not match.')].

		(self application settingList shouldMembersEnterEmail)
			ifTrue: [
				(self emailAddress = '')
					ifTrue: [
						errorDialogWidget addMessage: (self application translate: 'You cannot leave the email address empty.')].
			
				((self application memberRepository members select: [:each | each emailAddress = self emailAddress]) size > 0)
					ifTrue: [
						| errorMessage |
						
						errorMessage := (self application translate: 'The email address you entered has already been registered. Please enter another email address or contact the forum admin via {EmailAddress} email address.') copyReplaceAll: '{EmailAddress}' with: self application settingList emailAddress.
						
						errorDialogWidget addMessage: errorMessage]].

		(errorDialogWidget messages size > 0)
			ifTrue: [
				self lightbox: errorDialogWidget]
			ifFalse: [
				member := Member new.
				
				member memberName: self memberName.
				member password: (MD5 hexDigestOf: self password1).
				member emailAddress: self emailAddress.
				member hideEmail: false.
				member ip: self application request nativeRequest ip hostAddressString.
				
				self application memberRepository addMember: member.
				(self application memberRepository members size = 1)
					ifTrue: [
						self application settingList admins add: member].
				self application user: member.
				self application menuWidget markDirty.
				self application memberListWidget markDirty.
				self application topicListWidget markDirty].
	]
]
