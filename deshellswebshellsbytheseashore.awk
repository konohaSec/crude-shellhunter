#!/bin/awk

BEGIN { FS = "<\\?php"}
{
#If line matches shell pattern, and is on the first line, modify the file in place, and log what was changed.
if($0 ~ /<\?php if\(!isset\(\$GLOBALS\[\"\\x61\\156\\x75\\156\\x61\"\]\)\).*\$GLOBALS\[\"\\x61\\156\\x75\\156\\x61\"\]=1\; \} \?><\?php.*?>/ && NR == 1) 
{print "<\?php",$4 > FILENAME".tmp"; print "======\n""Removed line 1 shellcode:",FILENAME,"\n\nShellcode is:", $0"\n======" >> "/root/audit/run.log"}
#If line matches shell pattern, but is not on the first line, just log it.
else if($0 ~ /<\?php if\(!isset\(\$GLOBALS\[\"\\x61\\156\\x75\\156\\x61\"\]\)\).*\$GLOBALS\[\"\\x61\\156\\x75\\156\\x61\"\]=1\; \} \?><\?php.*?>/) 
{ print "======\n""Found additional shellcode:",FILENAME,", line",NR".\n\nShellcode is:", $0"\n======" >> "/root/audit/run.log"; print $0> FILENAME".tmp"}
else 
print $0 > FILENAME".tmp"
}
