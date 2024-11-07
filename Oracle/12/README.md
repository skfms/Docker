# Oracle Database 12.2.0.1

## 설치 : WSL2

## 환경
  
    ORACLE_BASE=/app/oracle
    ORACLE_HOME=/app/oracle/product/12.2/dbhome_1
    ORACLE_SID=orcl

    hostname=orc12
    port=1512:1521

## 구성

    ┬ ora12<br/>
    ├─ Dockerfile           # ora12 이미지 생성용 Dockerfile
    ├─ README               # 설명 문서
    ├─ install_ora12.sh     # ora12 설치용 이미지 생성 쉘 스크립트
    ├─ make_ora12.sh        # ora12 이미지 생성 쉘 스크립트
    ├─ run_db.sh            # ora12 DB & Listener start / stop
    ├─ run_ora12.sh         # ora12 이미지 실행 start / stop
    ├─ data                 # oracle 데이터 보관 폴더 (실행 시 oracle 데이터베이스 저장소)
    └┬ copy_files           # ora12 설치 파일 폴더
     ├─ db_install.rsp               # oracle 설치정보 설정 파일
     ├─ dbca.rsp                     # oracle DB 생성정보 설정 파일 - ORCL
     ├─ linuxx64_12201_database.zip  # oracle database 12.2.0.1
     ├─ listener.ora                 # oracle listener 파일
     ├─ netca.rsp                    # oracle listener 설치정보 파일
     ├─ oratab                       # dbstart / dbshut 설정 파일
     └─ tnsnames.ora                 # oracle tnsnames 파일

## 오라클 설치 순서

  1. oracle 설치
     
    $ make_ora12.sh                            # Docker 이미지 파일 생성
    $ install_ora12.sh                         # oracle 설치하기 위해 이미지 실행 : ./copy_files mount
    $ podman exec -it ora12 bash
      >$ su                                        # root
      >$ chown -R oracle:dba /data                 # mount 디렉토리 권한 변경
      >$ logout                                    # oracle
      >$ cd /data
      >$ unzip linuxx64_12201_database.zip         # oracle 12 설치 본 압축해제
      >$ cd $ORACLE_BASE
	  >$ cp /data/db_install.rsp .
      >$ /data/database/runInstaller -silent -ignoreSysPrereqs -showProgress -responseFile /data/db_install.rsp    # oracle 설치
      >$ su                                        # root
      >$ /app/oracle/oraInventory/orainstRoot.sh
      >$ /app/oracle/product/12.2/dbhome_1/root.sh
      >$ logout                                    # oracle
      >$ cp /data/dbca.rsp $ORACLE_HOME/assistants/dbca
      >$ cp /data/netca.rsp $ORACLE_HOME/assistants/netca
      ># cp /data/*.ora ~
      >$ cp /data/oratab ~
      >$ logout
    
  2. 컴포넌트 저장
     
    $ podman commit ora12 ora12:latest         # 현재 컴포넌트를 ora12:latest 이미지로 저장
    $ podman rm -f ora12                       # 컴포넌트 종료

  3. 원복
     
    $ sudo chown -R <uid>:<uid> copy_files     # copy_files 사용자 권한 복귀
    $ rm -rf copy_files/database               # oracle 설치 파일 삭제

  4. oracle database 생성
     
    $ mkdir -p ./data/oradata                  # Database 폴더 생성
	$ run_ora12.sh start                       # oracle 이미지 실행 : /data mount - 오라클 데이터 저장소
    $ podman exec -it ora12 bash
      >$ su                                        # root
      >$ chown oracle:dba $ORACLE_BASE/oradata     # mount 저장소를 oracle user로 변경
      >$ logout                                    # oracle
      >$ dbca -silent -createDatabase -responsefile $ORACLE_HOME/assistants/dbca/dbca.rsp    # 데이터베이스(orcl) 생성
      >$ netca -silent -responseFile $ORACLE_HOME/assistants/netca/netca.rsp                 # 리스너 생성
      >$ mv ~/*.ora $ORACLE_HOME/network/admin     # listener.ora, tnsnames.ora 파일 변경
      >$ cat ~/oratab > /etc/oratab                # dbstart / ddshut 가능하게 설정
      >$ logout

  4. 오라클 최종본 저장
     
    $ run_db.sh stop                           # oracle DB & Listener 실행 중지
    $ podman commit ora12 ora12:latest         # 최종 컨테이너를 이미지로 저장
    $ run_ora12.sh stop                        # 현재 컨테이너를 종료

## 오라클 실행 및 중지

    $ run_ora12.sh start
    $ run_db.sh start
    $ run_db.sh stop
    $ run_ora12.sh stop
  

