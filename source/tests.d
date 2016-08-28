import logd.log;

unittest {
	EnableLogging(true);
	assert(IsLogging);

	Log(Level.success, "Passed");

	// TODO: Finsih tests
}