Iliad.ILWidget subclass: MemberDetailsWidget [
	| member |
	
	<category: 'IyziForum-Buildables'>
	<comment: nil>
	
	member [
		<category: 'accessing'>
		
		^member
	]
	
	member: aMember [
		<category: 'accessing'>
		
		member := aMember
	]
	
	contents [
		^[:e |
			e table
				class: 'MemberDetails';
				cellspacing: self application settingList tableCellSpacings;
				build: [:table |
					| index |
					
					table tr build: [:tr |
						tr th
							text: (self application translate: 'Member Details');
							colspan: 2.
					
					(self application user loggedIn)
						ifFalse: [
							table tr td
								class: 'Dark1';
								style: 'height: 150px; text-align: center';
								colspan: 2;
								text: (self application translate: 'Only members can see the detailed information of other members.')]
						ifTrue: [
							(self member isNil)
								ifTrue: [
									table tr td
										class: 'Dark1';
										style: 'height: 150px; text-align: center';
										colspan: 2;
										text: (self application translate: 'No member specified.')]
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
											text: self member emailAddress;
											class: 'Light2'].

									table tr build: [:tr |
										tr td
											text: (self application translate: 'Registered On:');
											class: 'Dark1'.
											
										tr td
											text: (self member registrationDateTime printFormatted: self application settingList defaultDateFormat withTimeFormat: self application settingList defaultTimeFormat language: self application settingList defaultLanguage);
											class: 'Dark2'].

									table tr build: [:tr |
										tr td
											text: (self application translate: 'Last Here On:');
											class: 'Light1'.
											
										tr td
											text: (self member lastPresenceDateTime printFormatted: self application settingList defaultDateFormat withTimeFormat: self application settingList defaultTimeFormat language: self application settingList defaultLanguage);
											class: 'Light2'].

									table tr build: [:tr |
										tr td
											text: (self application translate: 'Post Count:');
											class: 'Dark1'.
											
										tr td
											text: ((self application postRepository posts select: [:post | post member = self member]) size) printString;
											class: 'Dark2']]]]]]
	]
]
