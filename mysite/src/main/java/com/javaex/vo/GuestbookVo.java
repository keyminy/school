package com.javaex.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class GuestbookVo {
	private int no;
	private String name;
	private String password;
	private String content;
	private Date reg_date;
	
	public GuestbookVo(String name, String password, String content) {
		super();
		this.name = name;
		this.password = password;
		this.content = content;
	}

	public GuestbookVo(int no, String password) {
		super();
		this.no = no;
		this.password = password;
	}
}
