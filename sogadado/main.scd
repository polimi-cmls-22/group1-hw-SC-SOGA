(
Server.killAll;
s.options.memSize = 262144;

// global param values referenced by the synths
~paramValues = [0.3, 0.5, 0.7, 0.3];
~action1 = {arg newValue; ~paramValues[0]=newValue.value;};
~action2 = {arg newValue; ~paramValues[1]=newValue.value;};
~action3 = {arg newValue; ~paramValues[2]=newValue.value;};
~action4 = {arg newValue; ~paramValues[3]=newValue.value;};

"./midi.scd".loadRelative;

/**********collection of sounds with their own knobs and effects******/
/************************Add here you own stuff***********************/
"./sounds/ditzy_test.scd".loadRelative;
"./sounds/temp.scd".loadRelative;
"./sounds/velocityEqualsOctave.scd".loadRelative;
"./sounds/yogaBabaGa.scd".loadRelative;
"./sounds/bolzen.scd".loadRelative;
"./sounds/sogarmonies.scd".loadRelative;


~sounds = Dictionary.new;
~sounds.put("ditzy", ~knobsDitzy);
~sounds.put("velocityEqualsOctave", ~knobsVelOct);
~sounds.put("stupidBass", ~knobsTemp);
~sounds.put("yogaBabaGa", ~knobsYog);
~sounds.put("bolzen", ~knobsBolzen);
~sounds.put("sogarmonies", ~knobsofstrings);

//chosen synthdef
~currentSynth = nil;

"./gui.scd".loadRelative;
)