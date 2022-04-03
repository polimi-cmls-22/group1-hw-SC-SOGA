(
/////////////////////////////
// AUDIO INITIALIZATION /////
/////////////////////////////
~selectAudioOutput = {
	arg selectedOutput;
	o = Server.default.options;
	o.outDevice_(selectedOutput);
	s.reboot;
};


/////////////////////////////
// MIDI INITIALIZATION //////
/////////////////////////////
~midiInit = {
	MIDIClient.init;
	MIDIIn.connectAll;
};


/////////////////////////////
// MIDI-SYNTH CONNECTION ////
/////////////////////////////
~midiSynthConnect = {
	arg synthName;
	var notes, on, off;
	var norm = 0.4; // normalization constant to prevent clipping

	q.value; // free all the notes, more details below

	notes = Array.newClear(128); // contains all the synths (a synth is created and added to this array when a midi note comes in)

	on = MIDIFunc.noteOn({ |veloc, num|
		notes[num] = Synth(synthName, [\freq, num.midicps, \amp, norm * veloc / 127, \param1, ~paramValues[0], \param2, ~paramValues[1], \param3, ~paramValues[2], \param4, ~paramValues[3]]);
	});

	off = MIDIFunc.noteOff({ |veloc, num|
		notes[num].release; // releasse note
		notes[num] = nil; // "remove" it from the notes array to prevent an error that comes from releasing an already released synth
	});

	/*
	Next time a synth will be assigned to the midi input the on and off variables will be freed.
	Also all the notes that are currently "on" will be released (otherwise they will play forever and you can't stop them).
	*/
	q = { on.free; off.free; notes.do({arg item; item.release;})};
};

/////////////////////////////
// RUN //////////////////////
/////////////////////////////
~midiInit.value;
)





