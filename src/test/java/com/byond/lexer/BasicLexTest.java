package com.byond.lexer;

import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.RecognitionException;
import org.antlr.runtime.Token;
import org.junit.Assert;
import org.junit.Test;

public class BasicLexTest {
	private DMLexer lexer;
	
	@Test
	public void basicString() throws RecognitionException {
		lexer = new DMLexer(new ANTLRStringStream("\"Hello \\\"world\\\"!\""));
		Token token = lexer.nextToken();
		Assert.assertEquals(DMLexer.String, token.getType());
	//	Assert.assertEquals("Hello \\\"world\\\"!", token.getText());	// Fix to handle this.
	//	Assert.assertEquals("Hello \"world\"!", token.getText());		// or ideally this if the escape char is parsed out.
	}
}
