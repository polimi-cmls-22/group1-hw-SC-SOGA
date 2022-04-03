~knobsofstrings = [["Harmonicajam", ~action1], ["Roomsize",~action2], ["Pan", ~action3], ["Amp", ~action4]];

SynthDef(\sogarmonies, {
	arg freq = 440, param4 = 1, param1 = 1,  param2 = 0.7, param3 = 0, gate=1;
	var sig1, amp1, env, width=0.7, harmonica = 1-param1;
	amp1 = LFPulse.kr(harmonica*2,0, 0.12) * param4;
	env = EnvGen.ar(Env.perc(0.1,0.4, curve:-4),gate, doneAction:0);
	sig1 = Saw.ar(freq,amp1)+ Saw.ar(freq*1.25,amp1)+ Saw.ar(freq*1.5,amp1)+Pulse.ar(freq*1.25,width,amp1) + Pulse.ar(freq*1.5,width,amp1);
	sig1 = sig1*env;
	sig1 = FreeVerb.ar(sig1, 1, param2, 0.8);
	Out.ar(0, Pan2.ar(sig1,2*param3-1));
}).add;
