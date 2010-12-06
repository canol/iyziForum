Iliad.ILWidget subclass: DialogWidget [
	| buttons messages |
	
	<category: 'IyziForum-Buildables'>
	<comment: nil>
	
	initialize [
		<category: 'initialization'>
		
		super initialize.
		
		messages := OrderedCollection new.
		buttons := OrderedCollection new.
	]
	
	contents [
		<category: 'building'>
		
		^[:e |
			e div
				style: 'width: 400px';
				build: self messageContents;
				br;
				build: self buttonContents]
	]
	
	messageContents [
		^[:e |
			(self messages size > 1)
				ifTrue: [
					e ul
						build: [:ul |
							self messages do: [:each |
								ul li text: each]]].
								
			(self messages size = 1)
				ifTrue: [
					e text: (self messages at: 1)]]
	]
	
	buttonContents [
		^[:e |
			e div
				style: 'text-align: center';
				build: [:div |
					self buttons do: [:button |
						div button
							text: (self application translate: button);
							onClickDo: [self answer: button].
						div space]]]
	]
	
	messages [
		<category: 'accessing'>
		
		^messages
	]
	
	messages: aMessageList [
		<category: 'accessing'>
		
		messages := aMessageList
	]
	
	addMessage: aString [
		<category: 'actions'>
		
		self messages add: aString.
	]
	
	buttons [
		<category: 'accessing'>
		
		^buttons
	]
	
	buttons: aButtonList [
		<category: 'accessing'>
		
		buttons := aButtonList
	]
	
	addButton: aDialogAnswerType [
		<category: 'actions'>
		
		self buttons add: aDialogAnswerType.
	]
]
