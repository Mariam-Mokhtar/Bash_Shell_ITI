
function authenticate {
	echo "Authentication.."
}

function querystudent {
	echo "Now query"
	echo -n "Enter student name to query GPA : "
	read NAME
	##We want to get line from datafile starts with NAME followed by :
	LINE=$(grep "^${NAME}:" datafile)
	if [ -z ${LINE} ]
	then
		echo "Error, student name ${NAME} not found"
	else
		GPA=$(echo ${LINE} | awk ' BEGIN { FS=":" } { print $2 } ')
		echo "GPA for ${NAME} is ${GPA}"
	fi
}


function insertstudent {
	echo "Inserting a new student"
	echo -n "Enter name : " 
	read NAME
	echo -n "Enter GPA : "
	read GPA
	### Before adding, we want to check GPA valid floating point or no
	checkFloatPoint ${GPA}
	if [ ${?} -ne 0 ]
	then
		echo "Error, GPA is not a positive floating number"
	else 
		echo "${NAME}:${GPA}" >> datafile
		echo "Student Added Successfully"
	fi
}

function deletestudent {
	echo "Deleting an existing student"
	echo -n "Enter student to delete : "
	read NAME
	##We want to get line from datafile starts with NAME followed by :
        LINE=$(grep "^${NAME}:" datafile)
        if [ -z ${LINE} ]
        then
                echo "Error, student name ${NAME} not found"
        else
		##BEfore delete, print confirmation message to delete or no
                echo "Are you sure you want to delete the student? (y/n)"
		read CONFIRM
		if [[ "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
		  # delete the student from the file
			  ##-v used to get lines DOES NOT contain regex
			  grep -v "^${NAME}:" datafile > /tmp/datafile
			  cp /tmp/datafile datafile
			  rm /tmp/datafile
			  echo "Student deleted successfully"
		else
		  	  echo "Student deletion cancelled"
		fi
		
        fi
}

function updatestudent {
	echo "Updating an existing student"
	echo -n "Enter student to update : "
	read NAME
	##We want to get line from datafile starts with NAME followed by :
        LINE=$(grep "^${NAME}:" datafile)
        if [ -z ${LINE} ]
        then
                echo "Error, student name ${NAME} not found"
        else
		##BEfore delete, print confirmation message to delete or no
                echo "Are you sure you want to update GPA for the student? (y/n)"
		read CONFIRM
		if [[ "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
			echo -n "Enter New GPA : "
			read GPA
			### Before adding, we want to check GPA valid floating point or no
			checkFloatPoint ${GPA}
			if [ ${?} -ne 0 ]
			then
				echo "Error, GPA is not a positive floating number"
			else 
				##-v used to get lines DOES NOT contain regex
				  grep -v "^${NAME}:" datafile > /tmp/datafile
				  echo "${NAME}:${GPA}" >> /tmp/datafile
				  cp /tmp/datafile datafile
				  rm /tmp/datafile
				  echo "Student Updated Successfully"
			fi
		else
		  	  echo "Student deletion cancelled"
		fi
		
        fi
}
