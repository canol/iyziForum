Object subclass: PostRepository [
	PostRepository class [
		| default |
	]
	
	| posts |
	
	<category: 'IyziForum-Data'>
	<comment: nil>
	
	PostRepository class >> new [
		<category: 'instance creation'>
		
		^self basicNew
			initialize;
			yourself
	]
	
	PostRepository class >> default [
		<category: 'accessing'>
		
		^default ifNil: [default := self new]
	]
	
	PostRepository class >> default: aPostRepository [
		<category: 'accessing'>
		
		default := aPostRepository
	]
	
	initialize [
		<category: 'initialization'>
		
		self posts: OrderedCollection new.
	]
	
	addPost: aPost [
		<category: 'actions'>
		
		self posts add: aPost.
	]
	
	posts [
		<category: 'accessing'>
		
		^posts
	]
	
	posts: anOrderedCollection [
		<category: 'accessing'>
		
		posts := anOrderedCollection.
	]
]
