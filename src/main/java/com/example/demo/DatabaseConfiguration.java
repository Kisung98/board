package com.example.demo;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration // xml로 설정하는 부분을 담당함 - 어노테이션
@PropertySource("classpath:/application.properties")
public class DatabaseConfiguration
{
	private static final Logger logger = LogManager.getLogger(DatabaseConfiguration.class);

	@Bean
	@ConfigurationProperties(prefix = "spring.datasource.hikari") // application.properties에 사용되는 속성값 접두어
	public HikariConfig hikariConfig()
	{// 메소드 리턴타입은 HikariConfig객체임
		return new HikariConfig();// 하드코딩 - 객체 생성- 메모리에 로딩되었다-메소드나 변수를 호출할 수있다.
	}


	@Bean
	public DataSource dataSource()
	{
		DataSource dataSource = new HikariDataSource(hikariConfig());
		return dataSource;
	}

	@Autowired
	private ApplicationContext applicationContext = null;// 게으른 컨테이너- 꼭 필요할 때 - 적재적소에

	@Bean
	public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception
	{

		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(dataSource);

		sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:/mapper/**/*.xml"));
		return sqlSessionFactoryBean.getObject();
	}


	@Bean
	public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory)
	{
		return new SqlSessionTemplate(sqlSessionFactory);
	}
}
