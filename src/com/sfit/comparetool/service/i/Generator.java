package com.sfit.comparetool.service.i;

import java.io.IOException;

public interface Generator {
	void generateEntity(String url, String username, String password, String resultPath) throws IOException;
}
