// just set the labels
~knobsVelOct = [["release", ~action1], ["velocity->octave",~action2], ["vibrato", ~action3], ["noise", ~action4]];

SynthDef(\velocityEqualsOctave, {
	/*
	Description: dreamy sound with 3 sinusoids. Velocity controls amplitude, octave and vibrato
	*/
	|
	freq, amp, gate=1, param1, param2, param3, param4 // args
	|
	var sound = 0;

	freq = freq*(2**((param2*amp*15).floor-2)); // select octave based on velocity

	sound = sound + ((SinOsc.ar(freq)+WhiteNoise.ar(param4*0.03))*EnvGen.kr(Env.perc(0.06, 6, curve:-80), gate, doneAction:2)); // main sinusoidal attack
	sound = sound + (0.2*SinOsc.ar(freq*3)*EnvGen.kr(Env.perc(0.02, 12, curve:-50), gate, doneAction:2)); // third harmonic just for fun, with slightly different envelope
	sound = sound + (0.3*SinOsc.ar(freq+(5*SinOsc.kr(30*amp*param3)))*EnvGen.kr(Env.perc(0.3,10*(0.1+param1),0.5, -8), gate, doneAction:2)); // longer sinusoid with slight vibrato controlled by velocity

	sound = Pan2.ar(sound, 0, 2*(amp**2)); // pan in the center, use velocity for amplitude

	Out.ar(0, sound);
}).add;
