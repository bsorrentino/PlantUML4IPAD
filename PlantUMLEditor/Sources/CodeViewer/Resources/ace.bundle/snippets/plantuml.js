ace.define("ace/snippets/plantuml.snippets",["require","exports","module"],function(e,t,n){var r='\n# Boundaries\nsnippet start\n	@startuml ${1:diagram name}\n	$0\n	@enduml\n# Scale\nsnippet scale\n	scale ${1:1.5}\n	${2:scale 1.5 | scale 200 width | scale 100 height | scale [max] 200x100}\n# Title\nsnippet tt\n	title \n	${1:multi-line text}$0\n	end title\n# Caption\nsnippet cap\n	caption ${1:Figure x.x description...}\n	$0\n# Legend\nsnippet leg\n	legend,\n		$0\n	end legend\n# node under\nsnippet link\n	${1:objAlias} ${2:.}. ${3:noteAlias}\n	$0\n# Note with direction\nsnippet note alias\n	note "${1:single-line note}" as ${2:noteAlias}\n	$0\n# Note Link\nsnippet note link\n	note ${1|left,right,top,bottom|} of ${2:objAlias}: ${3:single-line note}\n# Note multilines\nsnippet note link multi\n	note ${1|left,right,top,bottom|} of ${2:objAlias}\n		$0\n	end note\n# Header\n# This may be used to provide a date/time stamp of when the diagram was authored/reviewed\nsnippet hd\n	header ${1:last-updated xx/xx/xxxx}\n	$0\n# Header multilines\nsnippet hdn\n	header\n	${1:last-updated xx/xx/xxxx}$0\n	end header\n# Footer      \nsnippet ft\n	footer ${1:authored by xxx}\n	$0\n# Footer multilines\nsnippet ftn\n	footer\n	${1:authored by xxx}$0",\n	end footer\n# Separator\nsnippet sep\n	newpage ${1:title text}\n	$0\n',i='\n# actor\nsnippet act actor\n	${1:actor} ${2:alias}${3: as "${4:longName}"}${5: <<(${6:P},${7:#ADD1B2})${8|actor,participant,boundary,control,database,entity|}>>}\n	$0\n\n# auto incrementing numbered sequence \nsnippet num\n	autonumber ${1:nStartFrom} ${2:nStepBy}${3: "###"}\n$0\n\n# message between two objects \nsnippet msg\n	${1:objAlias1} ${2:->} ${3:objAlias2}: ${4:message}\n	${1:objAlias1} <-- ${3:objAlias2}: ${5:returnVal}\n	${6:\'Alt=> async msg: A->>B or A-\\B; lost msg: A->o]; found msg: Ao<-]}\n\n# incoming\nsnippet incoming\n	[-> ${1:objAlias}: ${2:message}\n\n# outgoing\nsnippet outgoing\n	${1:bjAlias} ->] : ${2:message}\n\n# hide footbox\nsnippet footbox\n	hide footbox\n\n# alternative or conditional execution\nsnippet alt\n	alt ${1:cond1}\n		$0\n	else ${2:cond2...}\n		\n	end\n\n# Adds an opt \nsnippet if opt\n	opt ${1:cond}\n		$0\n	end\n\n# Adds a loop \nsnippet loop\n	loop ${1:cond}\n		$0\n	end\n\n# parallel execution \nsnippet par\n	par ${1:threadName1}\n		$0\n	else ${2:threadName2...}\n		\n	end\n\n# exception/error handling block \nsnippet break exception\n	break ${1:catchCond1}\n		$0\n	else ${2:catchCond2...}\n		\n	else finally\n		\n	end\n\n# critical flow section\nsnippet critical\n	critical ${1:cond}\n		$0\n	end\n\n# group\nsnippet group\n	group ${1:basis}\n		$0\n	end\n\n# bounding box\nsnippet box\n	box "${1:caption}"\n		participant ${2:alias1}\n		${3:participant ${4:alias2}}$0\n	end box\n\n# note\nsnippet note\n	note ${1|left,right|} : ${3:single-line note}\n$0\n\n# note of the preceding message\nsnippet note multi\n	note ${1|left,right|}\n	${3:multi-line note}$0\n	end note\n\n# note over\nsnippet note over\n	note over ${1:commaSepAliases} : ${2:single-line note}\n$0\n\n# note over multiline\nsnippet note over multi\n	note over ${1:commaSepAliases}\n	${2:multi-line note}$0\n	end note\n\n# section divider \nsnippet div\n	== ${1:section} ==\n$0\n\n# text reference \nsnippet ref\n	ref over ${1:commaSepAliases}\n	${2:multi-line note}$0\n	end ref\n\n\n# delay\nsnippet delay ...\n	... ${1:elapsed time}...\n$0\n\n# additional spacing\nsnippet spacing\n	||${1:nPixels}||\n$0\n\n# object creation\nsnippet create new\n	create ${1:objAlias}\n$0\n\n# object destruction\nsnippet destroy delete\n	destroy ${1:objAlias}\n$0\n\n# active execution\nsnippet active on\n	activate ${1:objAlias}\n$0\n\n#  deactive execution\nsnippet deactive off\n	deactivate ${1:objAlias}\n$0\n\n# return\nsnippet return ret\n	return ${1:label}\n$0\n';n.exports=r+i}),ace.define("ace/snippets/plantuml",["require","exports","module","ace/snippets/plantuml.snippets"],function(e,t,n){"use strict";t.snippetText=e("./plantuml.snippets"),t.scope="plantuml"});                (function() {
                    ace.require(["ace/snippets/plantuml"], function(m) {
                        if (typeof module == "object" && typeof exports == "object" && module) {
                            module.exports = m;
                        }
                    });
                })();
            