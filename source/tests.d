import logd;

unittest {
	EnableLogging(true);
	assert(IsLogging);

	Log(Level.success, "Passed");

	// TODO: Finsih tests
}