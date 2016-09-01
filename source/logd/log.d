
module logd.log;

import std.stdio;
import std.file;
import std.string;
import std.datetime;
import std.format;

static class Logd {
	
	static private __gshared File log;
	static private __gshared bool isLogging = true;

	public enum Level {
		success = "success",
		event = "event",
		warning = "warning",
		error = "error",
		update = "update",
		user = "user",
	}

	static this() {
		log.open("log.html", "w");
		WriteHtmlHeader();
	}

	static ~this() {
		WriteHtmlFooter;
		Flush();
		log.close();
	}

	static public void SetLogFilename(string filename) {
		log.close();
		log.open(filename, "w");
		WriteHtmlHeader();
	}

	static public string GetFilename() {
		return log.name;
	}

	static public void Write()() {
		writeln();
		if(isLogging) 
			log.writeln();
	}

	static public void Write(Level, T...)(Level level, T t) {
		writeln(t);
		if(isLogging) 
			log.writeln("<p class=", level, ">", CurrentTime(),t,"</p>");
	}

	static public void WriteWithTag(Level, string, T...)(Level level, string fmt, T t){
		writeln(t);
		if(isLogging) 
			log.writeln("<",fmt," class=", level, ">",t,"</",fmt,">");
	}

	static public void EnableLogging(bool logging) {
		isLogging = logging;
	}

	static public bool IsLogging() {
		return isLogging;
	}

	static public void Flush() {
		std.stdio.stdout.flush();
		log.flush();
	}	

	static public string CurrentTime() {
		auto time = Clock.currTime;
		return format("(%s/%s/%s %s:%s:%s) - ", time.day, cast(int)time.month, time.year, time.hour, time.minute, time.second);
	}

	static private void WriteHtmlHeader(){
		log.writeln("<!DOCTYPE html>");
		log.writeln("<html>");
		log.writeln("<head>");
		log.writeln("<title>Log</title>");
		log.writeln("<style>");
		log.writeln("body{background-color: black;} p{margin-top: 5px; margin-bottom: 5px;} .success {color: lime;} .warning {color: orange;} .error {color: red;} .event {color: yellow;} .user{color: aqua;} .update {color: white;}");
		log.writeln("</style>");
		log.writeln("</head>");
		log.writeln("<body>");	
	}

	static private void WriteHtmlFooter() {
		log.writeln("</body>");
		log.writeln("</html>");
	}	
}