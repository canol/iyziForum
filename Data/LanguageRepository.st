Object subclass: LanguageRepository [
	LanguageRepository class [
		| default |
	]
	
	| languages defaultLanguage |
	
	<category: 'IyziForum-Data'>
	<comment: nil>
	
	LanguageRepository class >> new [
		<category: 'instance creation'>
		
		^self basicNew
			initialize;
			yourself
	]
	
	LanguageRepository class >> default [
		<category: 'accessing'>
		
		^default ifNil: [default := self new]
	]
	
	LanguageRepository class >> default: aLanguageRepository [
		<category: 'accessing'>
		
		default := aLanguageRepository
	]
	
	initialize [
		<category: 'initialization'>
		
		| firstLanguage |
		
		firstLanguage := Language new.
		
		self
			add: firstLanguage;
			defaultLanguage: firstLanguage.
	]
	
	add: aLanguage [
		<category: 'actions'>
		
		self languages add: aLanguage.
	]
	
	defaultLanguage [
		<category: 'accessing'>
		
		^defaultLanguage
	]
	
	defaultLanguage: aLanguage [
		<category: 'accessing'>
		
		defaultLanguage := aLanguage.
	]
	
	languages [
		<category: 'accessing'>
		
		^languages ifNil: [self languages: OrderedCollection new]
	]
	
	languages: anOrderedCollection [
		<category: 'accessing'>
		
		languages := anOrderedCollection.
	]
]
