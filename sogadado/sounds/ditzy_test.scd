~knobsDitzy = [["Width", ~action1], ["Max partials",~action2], ["Amp", ~action3], ["Fundamental", ~action4]];

SynthDef(\ditzy, {
	arg freq=140, param1=4, param2=200, param3=4, gate=1;
	var amp1, amp2, freq1, freq2, sig1, sig2 ;

	//qui trasformo il suono da un tono statico a dei pulse regolari con due fasi diverse (0 e 0.5)
	amp1 = LFPulse.kr(param1, 0, 0.12) * 0.75;
	amp2 = LFPulse.kr(param1, 0.5, 0.12) * 0.75;

	//'assegno alle frequenze un nuovo valore 8 volte al secondo con un range tra fund e fund*maxPartial arrotondato al multiplo piu vicino, quindi in questo caso LFNoise lancerà random overtone del fondamentale'
	freq1 = LFNoise0.kr(8).exprange(freq, freq*param2).round(freq);
	freq2 = LFNoise0.kr(8).exprange(freq, freq*param2).round(freq);

	//uso il pulse di qua sotto per creare dei salti di ottava, add 1 serve a modificare il range, normalmente sarebbe tra 0 e 1, cosi invece è tra 1 e 2
	freq1 = freq1 * LFPulse.kr(8, add:1);
	freq2 = freq2 * LFPulse.kr(6, add:1);
	//'i due segnali sono pulse waves'
	sig1 = Pulse.ar(freq1, param3, amp1);
	sig2 = Pulse.ar(freq2, param3, amp2);

	//aggiungo riverbero
	sig1 = FreeVerb.ar(sig1, 0.7, 0.8, 0.25);
	sig2 = FreeVerb.ar(sig2, 0.7, 0.8, 0.25);

	//'assegno l uscita (left o, right 1)'
	Out.ar(0, 0.5*sig1*EnvGen.kr(Env.adsr(0.1, curve:-80), gate, doneAction:2));
	Out.ar(1, 0.5*sig2*EnvGen.kr(Env.adsr(0.1, curve:-80), gate, doneAction:2));

}).add;