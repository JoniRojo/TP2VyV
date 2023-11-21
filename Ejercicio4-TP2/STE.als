sig Estado {}
sig Evento {}

sig STE {
	estados: set Estado,
	eventos: set Evento,
	estadoInicial: one Estado,
	transiciones:  estados -> eventos -> estados
}

sig Traza {
	estadosTraza : seq Estado
}

pred deadlock(ste : STE){
	some s : ste.estados | s in ((ste.estadoInicial).(*(transicionesSinEvento[ste]))) and no s.(transicionesSinEvento[ste])
}

fun transicionesSinEvento(ste : STE) : set Estado -> Estado {
	{s1, s2: ste.estados | some e: ste.eventos | s1 -> e -> s2 in ste.transiciones}
}

pred trazaEjecucion{
	(all t: Traza, ste: STE, i: t.estadosTraza.inds - t.estadosTraza.lastIdx |  
	 (t.estadosTraza.first = ste.estadoInicial) and
           (t.estadosTraza[plus[i,1]] in t.estadosTraza[i].(transicionesSinEvento[ste]))) 
	and (all t: Traza, ste: STE, i:  t.estadosTraza.inds | t.estadosTraza[i] in ste.estados) 
}

pred show[] { }

run trazaEjecucion for 3 but exactly 1 STE

run deadlock for 3 but exactly 1 STE

run show for 3 but exactly 1 STE
