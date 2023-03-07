xquery version "3.0";
declare namespace ead = "urn:isbn:1-931666-22-9";
declare namespace xlink = "http://www.w3.org/1999/xlink";

declare copy-namespaces preserve, inherit;
import module namespace functx = "http://www.functx.com"
at "http://www.xqueryfunctions.com/xq/functx-1.0-doc-2007-01.xq";

declare variable $ead as document-node()* := doc("path/to/file");

let $nodes := $ead//(*|@*|text())
let $pair := 
	for $node in $nodes 
	return 
	normalize-space(
	$node/../name() || '/' || 
	(
	if($node/self::attribute()) 
	then '@' 
	else if($node/self::text())
	then 'text()' 
	else ''
	) || 
	$node/name()
	) || codepoints-to-string(10)
 
return distinct-values($pair)
