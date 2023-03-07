xquery version "3.0";
declare namespace ead = "urn:isbn:1-931666-22-9";
declare namespace xlink = "http://www.w3.org/1999/xlink";

declare variable $ead as document-node()* := doc("path/to/file");

(:don't change those that require id's, nmtokens, or controlled values:)
let $nodes := $ead//(@*[not(matches(../name(), '^ead')) and not(matches(name(),'audience|id|type|normal|xlink|source|target|actuate|show|rules|render|code|level|type|calendar|era|continuation|sep|frame|align|charoff|^col|morerows|nameend|namest|tpattern'))]|text())

for $node in $nodes 
let $xpath := normalize-space(
		string-join($node/ancestor-or-self::element()/name(), '/') ||		
		(
		if($node/self::attribute()) 
		then 'ATTR' || $node/name()
		else if($node/self::text())
		then '/text()'
		else ''
		)
	)

return replace value of node $node with $xpath
