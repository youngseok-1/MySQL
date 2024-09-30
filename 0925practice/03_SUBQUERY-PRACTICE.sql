-- 1. 부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회하세요.
SELECT
	EMP_NAME
 FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT
						DEPT_CODE
                    FROM EMPLOYEE
                   WHERE EMP_NAME= '노옹철');
-- 2. 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하세요.
SELECT
	EMP_NO,
    EMP_NAME,
    JOB_CODE,
    SALARY
   FROM EMPLOYEE 
  WHERE SALARY > (SELECT 
					AVG(SALARY)
                  FROM EMPLOYEE);
-- 3. 노옹철 사원의 급여보다 많이 받는 직원의 사번, 이름, 부서, 직급, 급여를 조회하세요.
SELECT
	EMP_ID,
    EMP_NAME,
    DEPT_CODE,
    JOB_CODE,
    SALARY
   FROM EMPLOYEE
  WHERE SALARY > (SELECT
					SALARY
                    FROM EMPLOYEE
                   WHERE EMP_NAME = '노옹철');

-- 4. 가장 적은 급여를 받는 직원의 사번, 이름, 직급, 부서, 급여, 입사일을 조회하세요.
SELECT
    EMP_ID,
    EMP_NAME,
    DEPT_CODE,
    JOB_CODE,
    SALARY,
    HIRE_DATE
 FROM EMPLOYEE
WHERE SALARY = (
    SELECT MIN(SALARY)
    FROM EMPLOYEE
);        
-- *** 서브쿼리는 SELECT, FROM, WHERE, HAVING, ORDER BY절에도 사용할 수 있다.

-- 5. 부서별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여 조회하세요.
SELECT
    E.EMP_NAME,
    E.JOB_CODE,
    E.DEPT_CODE,
    E.SALARY
FROM EMPLOYEE E
WHERE E.SALARY = (
    SELECT 
		MAX(SALARY)
    FROM EMPLOYEE
    WHERE DEPT_CODE = E.DEPT_CODE OR (DEPT_CODE IS NULL AND E.DEPT_CODE IS NULL)
);

    

-- *** 여기서부터 난이도 극상

-- 6. 관리자에 해당하는 직원에 대한 정보와 관리자가 아닌 직원의 정보를 추출하여 조회하세요.
-- 사번, 이름, 부서명, 직급, '관리자' AS 구분 / '직원' AS 구분
-- HINT!! is not null, union(혹은 then, else), distinct
 -- 관리자인 경우: MANAGER_ID가 다른 직원에게 참조되는 경우
-- 관리자인 직원: EMP_ID가 다른 직원의 MANAGER_ID에 속한 경우
-- 관리자 먼저 사번 오름차순 정렬
-- 관리자 목록 먼저 출력
SELECT
    E.EMP_ID AS '사번',
    E.EMP_NAME AS '이름',
    D.DEPT_TITLE AS '부서명',
    J.JOB_NAME AS '직급',
    '관리자' AS '구분'
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE E.EMP_ID IN (
    SELECT DISTINCT MANAGER_ID
    FROM EMPLOYEE
    WHERE MANAGER_ID IS NOT NULL
)

UNION 

-- 직원 목록 출력
SELECT
    E.EMP_ID AS '사번',
    E.EMP_NAME AS '이름',
    D.DEPT_TITLE AS '부서명',
    J.JOB_NAME AS '직급',
    '직원' AS '구분'
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE E.MANAGER_ID IS NOT NULL

ORDER BY '구분' DESC, '사번' ASC;
-- 7. 자기 직급의 평균 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하세요.
-- 단, 급여와 급여 평균은 만원단위로 계산하세요.
-- HINT!! round(컬럼명, -5)
-- 7. 자기 직급의 평균 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하세요.
-- 단, 급여와 급여 평균은 만원단위로 계산하세요.
-- HINT!! round(컬럼명, -5)
SELECT 
	   E.EMP_CODE AS '사번',
       E.EMP_NAME AS '이름',
       E.JOB_CODE AS '직급코드',
       E.SALARY AS '급여'
  FROM EMPLOYEE E
 WHERE (E.JOB_CODE, E.SALARY) IN (SELECT A.JOB_CODE
                                       , ROUND(AVG(A.SALARY), -5)
                                    FROM EMPLOYEE E2
                                   GROUP BY A.JOB_CODE
                                 );
-- 8. 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의 이름, 직급, 부서, 입사일을 조회하세요.
SELECT
		E.EMP_NAME AS '이름',
        J.JOB_NAME AS '직급',
        D.DEPT_TITLE AS '부서',
        E.HIRE_DATE AS '입사일'
        FROM EMPLOYEE E
        JOIN JOB J ON E.JOB_CODE = J.JOB_CODE 
        JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
        WHERE (E.DEPT_TITLE, E.JOB_CODE) IN (SELECT 
-- 9. 급여 평균 3위 안에 드는 부서의 부서 코드와 부서명, 평균급여를 조회하세요.
-- HINT!! limit

-- 10. 부서별 급여 합계가 전체 급여의 총 합의 20%보다 많은 부서의 부서명과, 부서별 급여 합계를 조회하세요.