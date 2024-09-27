-- JOIN을 이용하여 여러 테이블을 조회 시에는 모든 컬럼에 테이블 별칭을 사용하는 것이 좋다.

-- 1. 직급이 대리이면서 아시아 지역에 근무하는 직원의 사번, 이름, 직급명, 부서명, 지역명, 급여를 조회하세요
SELECT
    A.EMP_ID AS '사번',
    A.EMP_NAME AS '이름',
    B.JOB_NAME AS '직급명',
    C.DEPT_TITLE AS '부서명',
    D.LOCAL_NAME AS '지역명',
    A.SALARY AS '급여'
FROM EMPLOYEE A
JOIN JOB B ON A.JOB_CODE = B.JOB_CODE
JOIN DEPARTMENT C ON A.DEPT_CODE = C.DEPT_ID
JOIN LOCATION D ON C.LOCATION_ID = D.LOCAL_CODE
WHERE B.JOB_NAME = '대리'
AND D.NATIONAL_CODE IN ('KO', 'JP', 'CH');
-- 2. 주민번호가 70년대 생이면서 성별이 여자이고, 성이 전씨인 직원의 이름, 주민등록번호, 부서명, 직급명을 조회하세요.
SELECT
    A.EMP_NAME AS '이름',
    A.EMP_NO AS '주민등록번호',
    B.DEPT_TITLE AS '부서명',
    C.JOB_NAME AS '직급명'
FROM EMPLOYEE A
JOIN DEPARTMENT B ON A.DEPT_CODE = B.DEPT_ID
JOIN JOB C ON A.JOB_CODE = C.JOB_CODE
WHERE A.EMP_NAME LIKE '전%' 
AND A.EMP_NO LIKE '7%'  
AND A.EMP_NO LIKE '_______2%' 
OR A.EMP_NO LIKE '_______4%';
-- 3. 이름에 '형'자가 들어가는 직원의 사번, 이름, 직급명을 조회하세요.
SELECT
	A.EMP_ID '사번',
    A.EMP_NAME '이름',
    B.JOB_NAME '직급'
  FROM EMPLOYEE A
 JOIN JOB B USING (JOB_CODE)
WHERE A.EMP_NAME LIKE '%형%'; 
-- 4. 해외영업팀에 근무하는 직원의 이름, 직급명, 부서코드, 부서명을 조회하세요.
SELECT
	A.EMP_NAME AS '이름',
    B.JOB_NAME AS '직급',
    A.DEPT_CODE AS '부서코드',
    C.DEPT_TITLE AS '부서명'
FROM EMPLOYEE A 
JOIN JOB B ON A.JOB_CODE = B.JOB_CODE
JOIN DEPARTMENT C ON A.DEPT_CODE = C.DEPT_ID
WHERE C.DEPT_ID IN ('D5', 'D6', 'D7');
-- 5. 보너스포인트를 받는 직원의 이름, 보너스, 부서명, 지역명을 조회하세요.
SELECT
    A.EMP_NAME AS '이름',
    A.BONUS AS '보너스',
    B.DEPT_TITLE AS '부서명',
    D.NATIONAL_NAME AS '지역명'
FROM EMPLOYEE A
JOIN DEPARTMENT B ON A.DEPT_CODE = B.DEPT_ID
JOIN LOCATION C ON B.LOCATION_ID = C.LOCAL_CODE
JOIN NATION D ON C.NATIONAL_CODE = D.NATIONAL_CODE
WHERE A.BONUS IS NOT NULL;
-- 6. 부서코드가 D2인 직원의 이름, 직급명, 부서명, 지역명을 조회하세오.
SELECT
    A.EMP_NAME AS '이름',
    B.JOB_NAME AS '직급명',
    C.DEPT_TITLE AS '부서명',
    N.NATIONAL_NAME AS '지역명'
FROM EMPLOYEE A
JOIN JOB B ON A.JOB_CODE = B.JOB_CODE
JOIN DEPARTMENT C ON A.DEPT_CODE = C.DEPT_ID
JOIN LOCATION L ON C.LOCATION_ID = L.LOCAL_CODE
JOIN NATION N ON L.NATIONAL_CODE = N.NATIONAL_CODE
WHERE A.DEPT_CODE = 'D2';
-- 7. 한국(KO)과 일본(JP)에 근무하는 직원의 이름, 부서명, 지역명, 국가명을 조회하세요.
SELECT
	E.EMP_NAME '이름',
    D.DEPT_TITLE '부서명',
    L.LOCAL_NAME '지역명',
    N.NATIONAL_NAME '국가명'
   FROM EMPLOYEE E
   JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
   JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
   JOIN NATION N ON L.NATIONAL_CODE = N.NATIONAL_CODE
  WHERE N.NATIONAL_NAME = '한국' OR N.NATIONAL_NAME = '일본';
    