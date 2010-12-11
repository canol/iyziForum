FormOnMenuWidget subclass: LoginWidget [
	| memberName password remember |
	
	<category: 'IyziForum-Buildables'>
	<comment: nil>
	
	initialize [
		<category: 'initialization'>
		
		super initialize.
		
		self memberName: ''.
		self password: ''.
		self remember: false.
	]
	
	contents [
		<category: 'building'>
		
		^[:e |
			e form
				build: [:form |
					form div
						id: 'LoginTop';
						class: 'Login';
						style: 'display: none';
						build: [:div |
							div text: (self application translate: 'Member Name:').
							div br.
							
							div input
								type: 'text';
								maxlength: self application settingList maxMemberNameCharacterCount;
								action: [:memberName | self memberName: memberName].
							div br.
							
							div text: (self application translate: 'Password:').
							div br.
							
							div input
								type: 'password';
								maxlength: '255';
								action: [:password | self password: password].
							div br.
							
							div button
								text: (self application translate: 'Login');
								action: [self login].
								
							div checkbox
								id: 'RememberMe';
								beSubmitOnClick;
								action: [:remember | self remember: remember].
							
							div label
								for: 'RememberMe';
								class: 'Small';
								text: (self application translate: 'Remember me')]]]
	]
	
	memberName [
		<category: 'accessing'>
		
		^memberName
	]
	
	memberName: aString [
		<category: 'accessing'>
		
		memberName := aString.
	]
	
	password [
		<category: 'accessing'>
		
		^password
	]
	
	password: aString [
		<category: 'accessing'>
		
		password := aString.
	]
	
	remember [
		<category: 'accessing'>
		
		^remember
	]
	
	remember: aBoolean [
		<category: 'accessing'>
		
		remember := aBoolean.
	]
	
	login [
		| members member errorDialogWidget |
		
		errorDialogWidget := DialogWidget new.
		errorDialogWidget addButton: DialogAnswerTypes okay.

		(self memberName = '')
			ifTrue: [
				errorDialogWidget addMessage: (self application translate: 'You cannot leave the member name empty.')].

		(self password = '')
			ifTrue: [
				errorDialogWidget addMessage: (self application translate: 'You cannot leave the password empty.')].

		members := self application memberRepository members select: [:each | each memberName = self memberName].

		((self application memberRepository members select: [:each | (each memberName = self memberName) and: [each status ~= MemberStatuses deleted]]) isEmpty)
			ifTrue: [
				errorDialogWidget addMessage: (self application translate: 'You entered a wrong member name or a member with this member name is not registered.')]
			ifFalse: [
				member := members at: 1.
		
				(member password = (MD5 hexDigestOf: self password))
					ifFalse: [
						errorDialogWidget addMessage: (self application translate: 'You entered a wrong password.')]].

		(errorDialogWidget messages isEmpty)
			ifTrue: [
				member remember: self remember.
				
				self application user: member.
				self application menuWidget markDirty.
				self application memberDetailsWidget markDirty.
				self application editMemberDetailsWidget markDirty.
				self application postListWidget markDirty]
			ifFalse: [
				self lightbox: errorDialogWidget].
	]
]
