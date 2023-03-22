-- employees 테이블 전체 내용 조회

SELECT
    *
FROM
    employees;

-- employee 테이블 first_name, last_name, job_id 만 조회

SELECT
    first_name,
    last_name,
    job_id
FROM
    employees;
    
-- 사원번호가 176인 사람의 LAST_NAME 조회
SELECT
    last_name
FROM
    employees
WHERE
    employee_id = 176;

-- 연봉이 12000 이상 되는 직원들의 LAST_NAME, SALARY 조회

SELECT
    last_name,
    salary
FROM
    employees
WHERE
    salary >= 12000;
    
    
-- 연봉이 5000 에서 12000 범위가 아닌 사람들의 LAST_NAME, SALARY 조회

SELECT
    last_name,
    salary
FROM
    employees
WHERE
    salary < 5000
    OR salary > 12000
ORDER BY
    last_name DESC;
    
    
-- 20, 50 번 부서에서 근무하는 모든 사원들의 LAST_NAME, 부서번호를 오름차순으로 조회
SELECT
    last_name,
    department_id
FROM
    employees
WHERE
    department_id IN ( 20, 50 )
ORDER BY
    last_name,
    department_id;

-- 커미션을 받는 모든 사원들의 LAST_NAME, 연봉, 커미션 조회(연봉의 내림차순, 커미션 내림차순)

SELECT
    last_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    commission_pct > 0
ORDER BY
    salary DESC,
    commission_pct DESC;


-- 연봉이 2500,3500,7000이 아니며 직업이 SA_REP 나 ST_CLERK 인 사원 조회

SELECT
    *
FROM
    employees
WHERE
    salary NOT IN ( 2500, 3500, 7000 )
    AND job_id IN ( 'SA_REP', 'ST_CLERK' );


-- 2008/02/20 ~ 2008/05/01 사이에 고용된 사원들의 last_name,사번,고용일자 조회
-- 고용일자 내림차순 정렬
-- 날짜 표현시 홑따옴표 안에 표현 - OR / 사용 가능

SELECT
    last_name,
    employee_id,
    hire_date
FROM
    employees
WHERE
        hire_date >= '2008-02-20'
    AND hire_date <= '2008-05-01'
ORDER BY
    hire_date DESC;

SELECT
    last_name,
    employee_id,
    hire_date
FROM
    employees
WHERE
    hire_date BETWEEN '2008-02-20' AND '2008-05-01'
ORDER BY
    hire_date DESC;


-- 2004년도에 고용된 사원들의 last_name, hire_date 조회
-- 고용일자 오름차순 정렬

SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
        hire_date >= '2004-01-01'
    AND hire_date <= '2004-12-31'
ORDER BY
    hire_date;

-- 부서가 20,50이고 연봉이 5000 에서 12000 범위인 사람들의 LAST_NAME, SALARY 조회
-- 연봉 오름차순 정렬

SELECT
    last_name,
    salary
FROM
    employees
WHERE
    department_id IN ( 20, 50 )
    AND salary BETWEEN 5000 AND 12000
ORDER BY
    salary;
    

-- LIKE    
-- 2004년도에 고용된 사원들의 last_name, hire_date 조회
-- 고용일자 오름차순 정렬    
    
SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
        hire_date LIKE '04%'
ORDER BY
    hire_date;    
    
-- LAST_NAME 에 u가 포함된 사원들의 사번, last_name 조회

SELECT
    employee_id,
    last_name
FROM
    employees
WHERE
    last_name LIKE '%u%';
    
-- LAST_NAME 에 네번째 글자가 a인 사원들의 last_name 조회    
    
SELECT
    employee_id,
    last_name
FROM
    employees
WHERE
    last_name LIKE '___a%';    
    
-- LAST_NAME 에 a 혹은 e 글자가 포함된 사원들의 last_name 조회  
-- last_name 오름차순 정렬

SELECT
    employee_id,
    last_name
FROM
    employees
WHERE
    last_name LIKE '%a%' or last_name LIKE '%e%' ORDER BY last_name; 

-- LAST_NAME 에 a 와 e 글자가 포함된 사원들의 last_name 조회  
-- last_name 오름차순 정렬    
    
SELECT
    employee_id,
    last_name
FROM
    employees
WHERE
    last_name LIKE '%a%e%' or last_name LIKE '%e%a%' ORDER BY last_name;    
    
-- 매니저(manager_id)가 없는 사람들의 last_name, job_id 조회

SELECT 
    last_name,
    job_id
FROM
    employees
WHERE
    manager_id IS NULL OR manager_id = '';

-- job_id가 ST_CLERK 가 사원의 부서번호 조회(단 부서번호가 NULL 인 사원은 제외한다.)
-- 중복을 제거한 후 부서번호만 조회

SELECT 
    DISTINCT department_id
FROM
    employees
WHERE
    job_id = 'ST_CLERK' AND department_id IS NOT NULL;

-- commission_pct 가 null이 아닌 사원들 중에서 commission = salary * commission_pct 를 구하여
-- employee_id, first_name, job_id 출력

SELECT 
    employee_id, first_name, job_id, salary * commission_pct AS commission
FROM
    employees    
WHERE
    commission_pct IS NOT NULL;
    
    
-- join 
-- 자신의 담당 매니저의 고용일 보다 빠른 입사자 찾기(self -join, employees)
-- hire_date, last_name, manager_id 조회

select e1.hire_date, e1.last_name, e1.manager_id
from employees e1, employees e2
where e1.manager_id = e2.employee_id and e1.hire_date<e2.hire_date;

--도시 이름이 t로 시작하는 지역에 사는 사원들의 사번, last_name, 부서번호, 도시 조회
--employees, departments inner join

SELECT
    e.employee_id,
    e.last_name,
    d.department_id,
    l.city
FROM
    employees   e,
    departments d,
    locations   l
WHERE
        e.department_id = d.department_id
    AND d.location_id = l.location_id
    AND l.city LIKE 'T%';
--
--employees, departments inner join

SELECT
    e.employee_id,
    e.last_name,
    d.department_id,
    e.salary
FROM
    employees   e,
    departments d
WHERE
        e.department_id = d.department_id
    AND d.location_id = 1700;

--부서명, 위치id ,각 부서별 사원 총 수, 각 부서별 평균 연봉 조회
-- 평균 연봉은 소수점 2자리까지만
-- empoyees, department inner join

SELECT
    d.department_name,
    d.location_id,
    count(e.employee_id),
    round(avg(e.salary),2)
FROM
    employees   e,
    departments d
WHERE
    e.department_id = d.department_id
group by
    d.department_name,
    d.location_id;

-- Executive 부서에 근무하는 사원들의 부서번호,last_name,job_id 조회
-- employees, department inner join

SELECT
    d.department_id,
    e.last_name,
    e.job_id
FROM
    employees   e,
    departments d
WHERE
    e.department_id = d.department_id and d.department_name = 'Executive';

-- 각 사원별 소속부서에서 자신보다 늦게 고용되었으나 보다 많은 연봉을 받는 사원이 존재하는 모든사원들의
-- 부서번호, 이름(first_name, last_name 연결하기),salary, hire_date 조회
-- employees self join

SELECT distinct
    e1.department_id,
    e1.first_name
    || ' '
    || e1.last_name AS name,
    e1.salary,
    e1.hire_date
FROM
    employees e1,
    employees e2
WHERE
        e1.department_id = e2.department_id
    AND e1.hire_date < e2.hire_date
    AND e1.salary < e2.salary;

-- 서브퀴리 
-- LAST_NAME에 u가 포함된 사원들과 동일 부서에 근무하는 사원들의 사번, LAST_NAME 조회

select employee_id, last_name
from employees e, departments d
where e.department_id = d.department_id and last_name like '%u%';


-- JOB_ID 가 SA_MAN 인 사원들의 최대 연봉보다 높게 받는 사원들의 LAST_NAME,JOB_ID,SALARY 조회
select LAST_NAME,JOB_ID, max(SALARY)
from employees
where job_id = 'SA_MAN'; in < (select sal from employees where job_id !='SA_MAN');



-- 커미션을 버는 사원들의 부서와 연봉이 동일한 사원들의 LAST_NAME,DEPARTMENT_ID,SALARY 조회
select LAST_NAME,DEPARTMENT_ID,SALARY
from employees 
where commission_pct is not null in (select DEPARTMENT_ID,SALARY from employees);



--회사 전체 평균 연봉보다 더 받는 사원들 중 LAST_NAEM에 u가 있는 사원들이 근무하는 부서에서 
--근무하는 사원들의 employee_id, last_name, salary 조회



-- last_name 이 Davies 인 사람보다 나중에 고용된 사원들의 last_name, hire_date 조회
select last_name, hire_date
from employees
where last_name = 'Davies' ;

-- last_name 이 King 인 사원을 매니저로 두고 있는 모든 사원들의 last_name, salary 조회
    
    
    
    
    
    