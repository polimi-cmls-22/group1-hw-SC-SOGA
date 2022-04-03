~knobsTemp = [["attack", ~action1], ["decay",~action2], ["sustain", ~action3], ["release", ~action4]];

SynthDef(\stupidBass, {
	/*
	Description: interesting waveform created by summing 15 pulse waves at multiple frequencies and then filtering each one of those with a bpf.
	*/
	|
	freq, amp, gate=1, param1=1, param2=0.5, param3, param4 // args
	|
	var sound = 0;

	20.do({arg i;
		sound = sound+BPF.ar(Pulse.ar(freq*(i+1), mul:1/(1+i)), freq*(i+1), 2*amp); // 20 pulse "harmonics", filtered with a narrow bpf
	});

	sound = sound*EnvGen.kr(Env.adsr(0.3*param1,param2,0.5*param3,param4, curve:-8), gate, doneAction:2); // envelope

	sound = Pan2.ar(sound, 0, sqrt(amp)); // pan in the center, use velocity for amplitude. Using the square root to exagerate the curve a bit, this synth works best with less dynamic.

	Out.ar(0, sound*0.5);
}).add;