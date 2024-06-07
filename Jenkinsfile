pipeline {
    agent any


    stages {

	stage("Pre-Runup-Cleanup"){
                agent any
                steps{ script{ try {
                        sh 'if [ $(docker ps | awk \'{print $1}\' | tail -1) ];then docker stop $(docker ps | awk \'{print $1}\' | tail -1);fi'
                }catch(Exception e){
			echo "No Docker lying around so no cleanup"	
		}
	      }
	    }
        }


	stage("Run Subfinder"){
		agent any
		steps{
			sh "docker run --rm -v \$(pwd):/src projectdiscovery/subfinder:latest -d priceless.com -o /src/output.txt"
			sh "ls -ltr && cat output.txt"
	
		}
	}
	
	stage("Run httpx"){
		when {
			allOf{
				expression {
					return fileExists('output.txt')
				}
				expression {
					return sh(script: 'stat -c %s "output.txt"', returnStdout: tru).toInteger() > 0
				}

			}
		}
		steps {
			echo "Running httpx against all the sub-domains"
		}
	
	}
	
	stage("Run-Nuclei"){
		when {
                        allOf{
                                expression {
                                        return fileExists('output.txt')
                                }
                                expression {
                                        return sh(script: 'stat -c %s "output.txt"', returnStdout: tru).toInteger() > 0
                                }

                        }
                }
		steps{
			sh 'docker run --rm -v $(pwd):/src projectdiscovery/nuclei:latest -l /src/output.txt'
		}

	}


	stage("Cleanup"){
		agent any
		steps{
			sh 'if [ $(docker ps | awk \'{print $1}\' | tail -1) ];then docker stop $(docker ps | awk \'{print $1}\' | tail -1);fi'
		}
	}
    }

}
