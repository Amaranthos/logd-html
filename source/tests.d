
unittest {
	import std.file;
	import std.path;
	import std.stdio;
	import std.algorithm;

	import logd.log;

	string fileName1 = "log".setExtension("html");
	string fileName2 = "test_log".setExtension("html");

	assert(fileName1 == "log.html");
	assert(fileName1 == Logd.Filename);
	assert(fileName2 == "test_log.html");

	scope(exit) {
		if(exists(fileName1)) {
			remove(fileName1);
		}

		if(exists(fileName2)) {
			remove(fileName2);
		}	

		assert(exists(fileName1) == false);
		assert(exists(fileName2) == false);
	}

	// Log is created on start
	assert(fileName1.exists);
	assert(fileName2.exists == false);	

	// Test toggling logging
	Logd.IsLogging = false;
	assert(Logd.IsLogging == false);

	Logd.Write(Logd.Level.success, "Not logging");

	Logd.IsLogging = true;
	assert(Logd.IsLogging);

	Logd.Write();
	Logd.Write(Logd.Level.success, "Logging enabled");	

	// Test changing log filename
	Logd.Filename = "test_log";
	assert(Logd.Filename == fileName2);
	assert(Logd.Filename.stripExtension == "test_log");
	
	// Test log content
	auto text = fileName1.readText;

	assert(text != "");	
	assert(text.canFind("<!DOCTYPE html>"));
	assert(text.canFind("Logging enabled"));
	assert(text.canFind("class=\"success\""));

	version(linux) {
		assert(text.canFind("\n\n"));
	}

	version(Windows) {
		assert(text.canFind("\r\n\r\n"));
	}

	assert(text.canFind("Not Logging") == false);
	assert(text.canFind("class=\"event\"") == false);
	assert(text.canFind("class=\"warning\"") == false);
	assert(text.canFind("class=\"error\"") == false);
	assert(text.canFind("class=\"update\"") == false);
	assert(text.canFind("class=\"user\"") == false);

	// Open Close
	Logd.Close();
	assert(Logd.IsOpen == false);
	Logd.Open();
	assert(Logd.IsOpen);
	Logd.Close();
}
