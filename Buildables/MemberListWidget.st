Iliad.ILWidget subclass: MemberListWidget [
	| members pagerWidget |
	
	<category: 'IyziForum-Buildables'>
	<comment: nil>
	
	initialize [
		<category: 'initialization'>
		
		super initialize.
		
		self members: OrderedCollection new.
		self pagerWidget: (PagerWidget new
			targetWidget: self;
			elementCountPerPage: self application settingList membersPerPage).
	]
	
	members [
		<category: 'accessing'>
		
		members := self application memberRepository members select: [:each | each status ~= MemberStatuses deleted].
		members := members asSortedCollection: [:member1 :member2 |
			member1 memberName < member2 memberName].
		
		^members
	]
	
	members: anOrderedCollection [
		<category: 'accessing'>
		
		members := anOrderedCollection
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
		
		^self members
	]
	
	elements: anOrderedCollection [
		<category: 'accessing'>
		
		self members: anOrderedCollection.
	]
	
	contents [
		^[:e |
			e table
				class: 'MemberList';
				cellspacing: self application settingList tableCellSpacings;
				build: [:table |
					| index |
					
					table tr build: [:tr |
						tr th
							text: (self application translate: 'Member');
							style: 'width: 50%'.
							
						tr th
							text: (self application translate: 'Email')].
							
					(self members size = 0)
						ifTrue: [
							table tr td
								class: 'Dark1';
								style: 'height: 150px; text-align: center';
								colspan: 2;
								text: (self application translate: 'There are no members yet.')].
					
					index := 1.
					self pagerWidget elements do: [:each |
						table tr build: [:tr || class |
							(index \\ 2 = 1)
								ifTrue: [
									class := 'Dark']
								ifFalse: [
									class := 'Light'].
							
							tr td
								class: (class, '1');
								build: [:td |
									td a
										linkToLocal: 'member/', (self application memberRepository members indexOf: each) printString;
										text: each memberName].
										
							tr td
								class: (class, '2');
								build: [:td |
									(each hideEmail)
										ifTrue: [
											td text: (self application translate: 'Hidden')]
										ifFalse: [
											td a
												href: 'mailto:', each emailAddress;
												text: each emailAddress]]].
						
						index := index + 1]].
						
			e build: self pagerWidget]
	]
	
	switchToPageNumber: aPositiveInteger [
		<category: 'actions'>
		
		(aPositiveInteger < 2 or: [aPositiveInteger > self pagerWidget pageCount])
			ifTrue: [
				self application redirectToLocal: 'members']
			ifFalse: [
				self application redirectToLocal: ('members/', aPositiveInteger printString)].
	]
]
