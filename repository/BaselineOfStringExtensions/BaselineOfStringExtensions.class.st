"
See https://github.com/hernanmd/StringExtensions for details.

"
Class {
	#name : #BaselineOfStringExtensions,
	#superclass : #BaselineOf,
	#category : #BaselineOfStringExtensions
}

{ #category : #baseline }
BaselineOfStringExtensions >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec
			baseline: 'FuzzySearch'			with: [ spec repository: 'github://hernanmd/FuzzySearcher/repository' ];
			baseline: 'ContainersOrderedSet' with: [ spec repository: 'github://pharo-containers/Containers-OrderedSet:v1.0/src' ].
		spec
			package: #StringExtensions							with: [ spec requires: #('FuzzySearch' 'OrderedSet') ];
			package: #StringExtensionsBenchmarks;
			package: #StringExtensionsLevenshtein 			with: [ spec requires: #(#StringExtensions ). ];
			package: #'StringExtensionsLevenshtein-Tests' 	with: [ spec requires: #(#StringExtensionsLevenshtein ). ];
			package: #StringExtensionsTests 					with: [ spec requires: #(#StringExtensions ). ].
		spec 
			group: 'default'		with: #(#Core);
			group: 'All' 			with: #(#StringExtensionsTests #StringExtensions #'StringExtensionsLevenshtein-Tests' #StringExtensionsLevenshtein 'FuzzySearch' 'OrderedSet');
			group: 'Benchmarks' 	with: #(#StringExtensionsLevenshtein #StringExtensionsBenchmarks #StringExtensions 'FuzzySearch');
			group: 'Core' 			with: #(#StringExtensions 'FuzzySearch' 'OrderedSet');
			group: 'Tests' 			with: #(#StringExtensions #StringExtensionsTests #StringExtensionsLevenshtein #'StringExtensionsLevenshtein-Tests' 'FuzzySearch') ].

]

{ #category : #doits }
BaselineOfStringExtensions >> ensureMetacelloFileDownload [

	Metacello new           
		baseline: 'MetacelloFileDownload';              
		repository: 'github://hernanmd/MetacelloFileDownload';          
		load.
]

{ #category : #doits }
BaselineOfStringExtensions >> platformFilesUrl [
	" Private - See superimplementor's comment "

	^ Array with: (String streamContents: [ : stream |		
		stream 			
			nextPutAll: 'https://github.com/hernanmd/StringExtensions/raw/master/';
			nextPutAll: (
				Smalltalk os isWin32 					
					ifTrue: [ 'words.zip' ]
					ifFalse: [ 'words.tar.gz' ]) ])
]

{ #category : #doits }
BaselineOfStringExtensions >> preLoad [

    self ensureMetacelloFileDownload.
    super preLoad.
]
