Object subclass: SettingList [
	SettingList class [ | default | ]

	| admins cookieName defaultDateFormat defaultTimeFormat defaultLanguage defaultSkinName emailAddress forumCharacterSet forumName forumTitle forumURL maxMemberNameCharacterCount maxMessageCharacterCount maxSubjectCharacterCount membersPerPage minMemberNameCharacterCount minMessageCharacterCount minPasswordCharacterCount minSubjectCharacterCount moderators postsPerPage publicFolderUrl shortForumDescription shouldMembersEnterEmail tableCellSpacings topicsPerPage totalMembers totalPosts webSiteName webSiteUrl |
	
	<category: 'IyziForum-Data'>
	<comment: nil>
	
	SettingList class >> default [
		^default ifNil: [default := self new]
	]
	
	SettingList class >> default: aSettingList [
		default := aSettingList
	]
	
	SettingList class >> new [
		^self basicNew
			admins: Set new;
			cookieName: 'iyzi Forum';
			defaultDateFormat: 'DD MMM YY';
			defaultTimeFormat: 'HH:MM:SS';
			defaultLanguage: nil;
			defaultSkinName: 'elegant';
			emailAddress: 'your@email.address';
			forumCharacterSet: 'UTF-8';
			forumName: 'Your Forum Name';
			forumTitle: 'Your Forum Title';
			forumURL: 'http://your.forum.url';
			maxMemberNameCharacterCount: 43;
			maxMessageCharacterCount: 100000;
			maxSubjectCharacterCount: 100;
			membersPerPage: 20;
			minMemberNameCharacterCount: 2;
			minMessageCharacterCount: 2;
			minPasswordCharacterCount: -1;
			minSubjectCharacterCount: 5;
			moderators: Set new;
			postsPerPage: 15;
			publicFolderUrl: 'http://localhost/~canol/iyziForum';
			shortForumDescription: 'Short description of your forum.';
			shouldMembersEnterEmail: false;
			tableCellSpacings: 0;
			topicsPerPage: 15;
			totalMembers: 0;
			totalPosts: 0;
			webSiteName: 'Your Web Site Name';
			webSiteUrl: 'http://your.website.url';
			yourself
	]
	
	admins [
		<category: 'accessing'>
		
		^admins
	]
	
	admins: aSet [
		<category: 'accessing'>
		
		admins := aSet.
	]
	
	cookieName [
		<category: 'accessing'>
		
		^cookieName
	]
	
	cookieName: aString [
		<category: 'accessing'>
		
		cookieName := aString.
	]
	
	defaultDateFormat [
		<category: 'accessing'>
		
		^defaultDateFormat
	]
	
	defaultDateFormat: aString [
		<category: 'accessing'>
		
		defaultDateFormat := aString.
	]
	
	defaultTimeFormat [
		<category: 'accessing'>
		
		^defaultTimeFormat
	]
	
	defaultTimeFormat: aString [
		<category: 'accessing'>
		
		defaultTimeFormat := aString.
	]
	
	defaultLanguage [
		<category: 'accessing'>
		
		^defaultLanguage
	]
	
	defaultLanguage: aLanguage [
		<category: 'accessing'>
		
		defaultLanguage := aLanguage.
	]
	
	defaultSkinName [
		<category: 'accessing'>
		
		^defaultSkinName
	]
	
	defaultSkinName: aString [
		<category: 'accessing'>
		
		defaultSkinName := aString.
	]
	
	emailAddress [
		<category: 'accessing'>
		
		^emailAddress
	]
	
	emailAddress: aString [
		<category: 'accessing'>
		
		emailAddress := aString.
	]
	
	forumCharacterSet [
		<category: 'accessing'>
		
		^forumCharacterSet
	]
	
	forumCharacterSet: aString [
		<category: 'accessing'>
		
		forumCharacterSet := aString.
	]
	
	forumName [
		<category: 'accessing'>
		
		^forumName
	]
	
	forumName: aString [
		<category: 'accessing'>
		
		forumName := aString.
	]
	
	forumTitle [
		<category: 'accessing'>
		
		^forumTitle
	]
	
	forumTitle: aString [
		<category: 'accessing'>
		
		forumTitle := aString.
	]
	
	forumURL [
		<category: 'accessing'>
		
		^forumURL
	]
	
	forumURL: aString [
		<category: 'accessing'>
		
		forumURL := aString.
	]
	
	maxMemberNameCharacterCount [
		<category: 'accessing'>
		
		^maxMemberNameCharacterCount
	]
	
	maxMemberNameCharacterCount: anInteger [
		<category: 'accessing'>
		
		maxMemberNameCharacterCount := anInteger.
	]
	
	maxMessageCharacterCount [
		<category: 'accessing'>
		
		^maxMessageCharacterCount
	]
	
	maxMessageCharacterCount: anInteger [
		<category: 'accessing'>
		
		maxMessageCharacterCount := anInteger.
	]
	
	maxSubjectCharacterCount [
		<category: 'accessing'>
		
		^maxSubjectCharacterCount
	]
	
	maxSubjectCharacterCount: anInteger [
		<category: 'accessing'>
		
		maxSubjectCharacterCount := anInteger.
	]
	
	membersPerPage [
		<category: 'accessing'>
		
		^membersPerPage
	]
	
	membersPerPage: anInteger [
		<category: 'accessing'>
		
		membersPerPage := anInteger.
	]
	
	minMemberNameCharacterCount [
		<category: 'accessing'>
		
		^minMemberNameCharacterCount
	]
	
	minMemberNameCharacterCount: anInteger [
		<category: 'accessing'>
		
		minMemberNameCharacterCount := anInteger.
	]
	
	minMessageCharacterCount [
		<category: 'accessing'>
		
		^minMessageCharacterCount
	]
	
	minMessageCharacterCount: anInteger [
		<category: 'accessing'>
		
		minMessageCharacterCount := anInteger.
	]
	
	minPasswordCharacterCount [
		<category: 'accessing'>
		
		^minPasswordCharacterCount
	]
	
	minPasswordCharacterCount: anInteger [
		<category: 'accessing'>
		
		minPasswordCharacterCount := anInteger.
	]
	
	minSubjectCharacterCount [
		<category: 'accessing'>
		
		^minSubjectCharacterCount
	]
	
	minSubjectCharacterCount: anInteger [
		<category: 'accessing'>
		
		minSubjectCharacterCount := anInteger.
	]
	
	moderators [
		<category: 'accessing'>
		
		^moderators
	]
	
	moderators: aSet [
		<category: 'accessing'>
		
		moderators := aSet.
	]
	
	postsPerPage [
		<category: 'accessing'>
		
		^postsPerPage
	]
	
	postsPerPage: anInteger [
		<category: 'accessing'>
		
		postsPerPage := anInteger.
	]
	
	publicFolderUrl [
		<category: 'accessing'>
		
		^publicFolderUrl
	]
	
	publicFolderUrl: aString [
		<category: 'accessing'>
		
		publicFolderUrl := aString.
	]
	
	shortForumDescription [
		<category: 'accessing'>
		
		^shortForumDescription
	]
	
	shortForumDescription: aString [
		<category: 'accessing'>
		
		shortForumDescription := aString.
	]
	
	shouldMembersEnterEmail [
		<category: 'accessing'>
		
		^shouldMembersEnterEmail
	]
	
	shouldMembersEnterEmail: aBoolean [
		<category: 'accessing'>
		
		shouldMembersEnterEmail := aBoolean.
	]
		
	tableCellSpacings [
		<category: 'accessing'>
		
		^tableCellSpacings
	]
	
	tableCellSpacings: anInteger [
		<category: 'accessing'>
		
		tableCellSpacings := anInteger.
	]
	
	topicsPerPage [
		<category: 'accessing'>
		
		^topicsPerPage
	]
	
	topicsPerPage: anInteger [
		<category: 'accessing'>
		
		topicsPerPage := anInteger.
	]
	
	totalMembers [
		<category: 'accessing'>
		
		^topicsPerPage
	]
	
	totalMembers: anInteger [
		<category: 'accessing'>
		
		totalMembers := anInteger.
	]
	
	totalPosts [
		<category: 'accessing'>
		
		^totalPosts
	]
	
	totalPosts: anInteger [
		<category: 'accessing'>
		
		totalPosts := anInteger.
	]
	
	webSiteName [
		<category: 'accessing'>
		
		^webSiteName
	]
	
	webSiteName: aString [
		<category: 'accessing'>
		
		webSiteName := aString.
	]
	
	webSiteUrl [
		<category: 'accessing'>
		
		^webSiteUrl
	]
	
	webSiteUrl: aString [
		<category: 'accessing'>
		
		webSiteUrl := aString.
	]
]
