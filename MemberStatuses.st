Object subclass: MemberStatuses [
	
	<category: 'IyziForum'>
	<comment: nil>
	
	MemberStatuses class >> active [
		<category: 'enumeration'>
		
		^'Active'
	]
	
	MemberStatuses class >> banned [
		<category: 'enumeration'>
		
		^'Banned'
	]
	
	MemberStatuses class >> deleted [
		<category: 'enumeration'>
		
		^'Deleted'
	]
]
