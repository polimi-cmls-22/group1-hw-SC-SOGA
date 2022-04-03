~knobsYog = [["fake microtonal", ~action1], ["sparullero",~action2], ["sprinkle dinkle", ~action3], ["sprinkle mix", ~action4]];

SynthDef(\yogaBabaGa, {
	|
	freq, amp, gate=1, param1, param2, param3, param4 // args
	|
	var sound = 0;

	3.do({arg i;
		sound = sound + LFTri.ar(freq*(i+(1+(amp*param1/10))), mul: (1/(i+1))*(1-param4));
	});

	sound = sound + (DelayN.ar(LFTri.ar([freq*(4+(1+(amp*param1/10))), freq*4], mul: 0.4*param4), param3, param3)); // higher freq, delayed
	sound = sound + (DelayN.ar(LFTri.ar([freq*(6+(1+(amp*param1/10))), freq*6], mul: 0.2*param4), param3, param3)); // higher freq 2

	//sound = sound*EnvGen.kr(Env.adsr(0.01,0.3,0.2,2, curve:-8), gate, doneAction:2);
	sound = sound*EnvGen.kr(Env.adsr(1,1,0.3,3), gate, doneAction:2);

	sound = sound*LFTri.ar((param2**2)*15); // triangle tremolo

	sound = Pan2.ar(sound, 0, 2*(amp**2)); // pan in the center, use velocity for amplitude

	Out.ar(0, sound);
}).add;