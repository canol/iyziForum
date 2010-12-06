Iliad.ILWidget subclass: NavigationWidget [
	| elements |
	
	<category: 'IyziForum-Buildables'>
	<comment: nil>
	
	initialize [
		<category: 'initialization'>
		
		super initialize.
		
		self elements: OrderedCollection new.
	]
	
	addUrl: aUrl text: aString [
		<category: 'actions'>
		
		self elements add: aString, '|', aUrl.
		self markDirty.
	]
	
	addText: aString [
		<category: 'actions'>
		
		self elements add: aString.
		self markDirty.
	]
	
	clear [
		<category: 'actions'>
		
		self elements: OrderedCollection new.
		self markDirty.
	]
	
	elements [
		<category: 'accessing'>
		
		^elements
	]
	
	elements: anOrderedCollection [
		<category: 'accessing'>
		
		^elements := anOrderedCollection
	]
	
	contents [
		^[:e |
			e div
				class: 'Navigation';
				build: [:div |
					div a
						linkToApplication: self application class;
						text: (self application translate: 'Main Page').
						
					self elements do: [:each |
						| subElements |
						
						div space; html: '&#187;'; space.
						
						subElements := each subStrings: '|'.
						
						(subElements size = 2)
							ifTrue: [
								div a
									linkToLocal: (subElements at: 2);
									text: (subElements at: 1)].
									
						(subElements size = 1)
							ifTrue: [
								div text: (subElements at: 1)]]]]
	]
]
