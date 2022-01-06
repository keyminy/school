package com.javaex.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BoardVo {
	private int no;
	private String title;
	private String content;
	private String name;
	private int hit;
	private Date reg_date;
	private int user_no;
}
