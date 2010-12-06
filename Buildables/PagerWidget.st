Iliad.ILWidget subclass: PagerWidget [
	| targetWidget elementCountPerPage currentPageNumber |
	
	<category: 'IyziForum-Buildables'>
	<comment: nil>
	
	initialize [
		<category: 'initialization'>
		
		super initialize.
		
		self elementCountPerPage: 1.
		self currentPageNumber: 1.
	]
	
	targetWidget [
		<category: 'accessing'>
		
		^targetWidget
	]
	
	targetWidget: anILWidget [
		<category: 'accessing'>
		
		targetWidget := anILWidget.
	]
	
	elementCountPerPage [
		<category: 'accessing'>
		
		^elementCountPerPage
	]
	
	elementCountPerPage: aPositiveInteger [
		<category: 'accessing'>
		
		elementCountPerPage := aPositiveInteger.
	]
	
	currentPageNumber [
		<category: 'accessing'>
		
		^currentPageNumber
	]
	
	currentPageNumber: aPositiveInteger [
		<category: 'accessing'>
		
		currentPageNumber := aPositiveInteger.
		
		self markDirty.
		(self targetWidget isNil)
			ifFalse: [
				self targetWidget markDirty].
	]
	
	elements [
		<category: 'accessing'>
		
		| lowerLimit upperLimit filteredElements |
		
		lowerLimit := 1 + ((self currentPageNumber - 1) * self elementCountPerPage).
		upperLimit := self currentPageNumber * self elementCountPerPage.
		
		(lowerLimit > self targetWidget elements size)
			ifTrue: [
				filteredElements := OrderedCollection new]
			ifFalse: [
				(upperLimit > self targetWidget elements size)
					ifTrue: [
						filteredElements := self targetWidget elements copyFrom: lowerLimit to: self targetWidget elements size]
					ifFalse: [
						filteredElements := self targetWidget elements copyFrom: lowerLimit to: upperLimit]].
		
		^filteredElements.
	]
	
	contents [
		<category: 'building'>
		
		^[:e |
			(self pageCount > 1)
				ifTrue: [
					e div
						class: 'Pages';
						build: [:div |
							1 to: self pageCount
								do: [:pageNumber |
									| tempPageNumber |
									
									tempPageNumber := pageNumber.
									
									(pageNumber ~= 1)
										ifTrue: [
											div text: ', '].
									
									(pageNumber = self currentPageNumber)
										ifTrue: [
											div span
												class: 'CurrentPage';
												text: tempPageNumber printString]
										ifFalse: [
											div a
												text: tempPageNumber printString;
												action: [self targetWidget switchToPageNumber: tempPageNumber]]]]]]

	]
	
	pageCount [
		^(self targetWidget elements size / self elementCountPerPage) ceiling
	]
]
