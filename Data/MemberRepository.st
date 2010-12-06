Object subclass: MemberRepository [
	MemberRepository class [
		| default |
	]
	
	| members |
	
	<category: 'IyziForum-Data'>
	<comment: nil>
	
	MemberRepository class >> new [
		<category: 'instance creation'>
		
		^self basicNew
			initialize;
			yourself
	]
	
	MemberRepository class >> default [
		<category: 'accessing'>
		
		^default ifNil: [default := self new]
	]
	
	MemberRepository class >> default: aMemberRepository [
		<category: 'accessing'>
		
		default := aMemberRepository
	]
	
	initialize [
		<category: 'initialization'>
		
		self members: OrderedCollection new.
	]
	
	addMember: aMember [
		<category: 'actions'>
		
		self members add: aMember.
	]
	
	members [
		<category: 'accessing'>
		
		^members
	]
	
	members: anOrderedCollection [
		<category: 'accessing'>
		
		members := anOrderedCollection.
	]
]
