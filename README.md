# logd-html

logd-html is a lightweight logger which writes to a html file;
this allows formatted output and the potential for controls to review specific events, etc.
Based on logger originally written by [Patrick Monaghan](https://github.com/manpat)

## How to use

Install using dub

```
dub fetch logd-html
```

General usage

```D
import logd-html;

void main() {
	EnableLogging(true);

	// By default will log to file "log.html"
	SetLogFilename("sampleLog.html");

	// Write newline
	Log();

	// Write to log, valid levels are:
	//	success
	//	event
	//	warning
	//	error
	//	update
	//	user
	Log(Level.event, "Hello world");

	// Log with header tag
	LogTag(Level.user, "h1", "This is a header");	
}
```
# Todo

- Define config file to customize formatted output (not sure about this, could lead to a bulkier system than I would like)
- Add some js to interact with log file (e.g. hide particular levels, highlight keywords, etc)
- Validate allowable tags for LogTag