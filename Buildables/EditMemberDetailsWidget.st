Iliad.ILWidget subclass: EditMemberDetailsWidget [
	| member memberName password1 password2 emailAddress hideEmail |
	
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
	
	member [
		<category: 'accessing'>
		
		^member
	]
	
	member: aMember [
		<category: 'accessing'>
		
		member := aMember
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
	
	contents [
		^[:e |
			e form
				build: [:form |
					form table
						class: 'EditMemberDetails';
						cellspacing: self application settingList tableCellSpacings;
						build: [:table |
							| index |
							
							table tr build: [:tr |
								tr th
									text: (self application translate: 'Edit Member Details');
									colspan: 2.
							
							(self application user loggedIn)
								ifFalse: [
									table tr td
										class: 'Dark1';
										style: 'height: 150px; text-align: center';
										colspan: 2;
										text: (self application translate: 'You should first login to edit member details.')]
								ifTrue: [
									(self member isNil)
										ifTrue: [
											table tr td
												class: 'Dark1';
												style: 'height: 150px; text-align: center';
												colspan: 2;
												text: (self application translate: 'No member specified.')]
										ifFalse: [
											(self member ~= self application user and: [(self application isBoardMember: self application user) not])
												ifTrue: [
													table tr td
														class: 'Dark1';
														style: 'height: 150px; text-align: center';
														colspan: 2;
														text: (self application translate: 'You don''t have permission to edit these details.')]
												ifFalse: [
													table tr build: [:tr |
														tr td
															text: (self application translate: 'Member Name:');
															class: 'Dark1';
															style: 'width: 30%'.
															
														tr td
															text: self member memberName;
															class: 'Dark2'].

													table tr build: [:tr |
														tr td
															text: (self application translate: 'Email Address:');
															class: 'Light1'.
															
														tr td
															class: 'Light2';
															build: [:td |
																td input
																	maxlength: '255';
																	value: self member emailAddress;
																	action: [:emailAddress | self emailAddress: emailAddress].
																	
																(self application settingList shouldMembersEnterEmail)
																	ifTrue: [
																		td text: '*']]].

													table tr build: [:tr |
														tr td
															text: (self application translate: 'New Password:');
															class: 'Dark1'.
															
														tr td
															class: 'Dark2';
															build: [:td |
																td input
																	type: 'password';
																	maxlength: '255';
																	action: [:password1 | self password1: password1]]].

													table tr build: [:tr |
														tr td
															text: (self application translate: 'New Password Again:');
															class: 'Light1'.
															
														tr td
															class: 'Light2';
															build: [:td |
																td input
																	type: 'password';
																	maxlength: '255';
																	action: [:password2 | self password2: password2]]].

													table tr build: [:tr |
														tr td
															colspan: 2;
															class: 'Buttons';
															build: [:td |
																td button
																	text: (self application translate: 'Save');
																	action: [self save]]]]]]]]]]
	]
	
	save [
		| errorDialogWidget |
		
		errorDialogWidget := DialogWidget new.
		errorDialogWidget addButton: DialogAnswerTypes okay.

		(self password1 ~= '')
			ifTrue: [
				(self application settingList minPasswordCharacterCount ~= -1)
					ifTrue: [
						(self password1 size < self application settingList minPasswordCharacterCount)
							ifTrue: [
								| errorMessage |
								
								errorMessage := (self application translate: 'The password cannot be shorter than {MinPasswordCharacterCount} characters.') copyReplaceAll: '{MinPasswordCharacterCount}' with: self application settingList minPasswordCharacterCount printString.
								
								errorDialogWidget addMessage: errorMessage]]].

		(self password1 ~= '' and: [self password2 = ''])
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
				(self password1 ~= '')
					ifTrue: [
						self member password: (MD5 hexDigestOf: self password1)].
				self member emailAddress: self emailAddress.
				self member hideEmail: self hideEmail.
				
				errorDialogWidget addMessage: (self application translate: 'Succesfully saved the member details.').
				self lightbox: errorDialogWidget].
	]
]
