~knobsBolzen = [["release", ~action1], ["slide time",~action2], ["filter", ~action3], ["q", ~action4]];

SynthDef(\bolzen, {
	|
	freq, amp, gate=1, param1, param2, param3, param4 // args
	|
	var sound;

	var env = EnvGen.kr(Env.perc(0.01, 0.1+(2*param2), -1), gate);
	freq = freq*(1+env);

	sound = Pulse.ar(freq);

	sound = sound*EnvGen.kr(Env.adsr(0.01,0.8,0.3,param1*3), gate, doneAction:2);

	sound = RLPF.ar(sound, 50+(param3*15000*amp), 0.15-(param4/10));

	sound = Pan2.ar(sound, 0, amp);

	Out.ar(0, sound);
}).add;