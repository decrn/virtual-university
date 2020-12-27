const namespaces = `
PREFIX : <http://onto.virtual-university.org#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX fo: <http://www.w3.org/1999/XSL/Format#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
`

const queries = {
    getAllTeachers: () => `
        SELECT ?teacher ?firstName ?lastName ?id
        WHERE {
            ?teacher a :Teacher .
            ?teacher foaf:firstName ?firstName .
            ?teacher foaf:familyName ?lastName .
            ?teacher :employeeId ?id .
        }
    `,
    getCoursesForTeacher: (employeeId) => `
    SELECT DISTINCT ?code ?name ?credits ?bbc ?zmc ?prc ?mtc
    WHERE {
        ?class :partOfCourse ?course .
        ?class :classTaughtBy ?teacher .
        ?teacher :employeeId '${employeeId}' .
        ?course :courseCode ?code .
        ?course :courseName ?name .
        ?course :courseCredits ?credits .
        ?class :hostedInClassroom ?classroom .
        {
            SELECT (COUNT(*) AS ?bbc)
            WHERE {
            ?classroom a :BigBlueButtonConference .
            }
        }
        {
            SELECT (COUNT(*) AS ?zmc)
            WHERE {
            ?classroom a :ZoomMeeting .
            }
        }
        {
            SELECT (COUNT(*) AS ?prc)
            WHERE {
            ?classroom a :PanoptoRecording .
            }
        }
        {
            SELECT (COUNT(*) AS ?mtc)
            WHERE {
            ?classroom a :MicrosoftTeamsMeeting .
            }
        }  
    }
    `,
    getTeacherInfo: (employeeId) => `
    SELECT ?teacher ?firstName ?lastName
    WHERE {
        ?teacher :employeeId '${employeeId}' .
        ?teacher foaf:firstName ?firstName .
        ?teacher foaf:familyName ?lastName .
    }
    `,
    getAttendance: (courseCode) => `
    SELECT ?date (COUNT(?student) AS ?attendance)
    WHERE {
        ?course :courseCode '${courseCode}' .
        ?class :partOfCourse ?course .
        ?class :classStartDate ?date .
        ?student :attendsClass ?class .
    }
    GROUP BY ?date
    ORDER BY ASC(?date)
    `,
    getPollActivity: (courseCode) => `
    SELECT ?question (COUNT(?polloption) AS ?votes)
    WHERE {
        {
            ?course :courseCode '${courseCode}' .
            ?course :courseOf ?class .
            ?class :hostedInClassroom ?classroom .
            ?classroom :hasPoll ?poll .
            ?poll :hasPollOption ?polloption .
            ?polloption :pollOptionChosenBy ?student .
            ?poll :pollQuestion ?question .
        } 
    }
    GROUP BY ?poll ?question
    `,
    getActivityMetric: (courseCode) => `
    SELECT ?student ?firstName ?lastName ?activity
    WHERE {
        {
            SELECT ?student ?firstName ?lastName (COUNT(?class) AS ?attendance) (COUNT(?option) as ?votes)
            WHERE {
                ?course :courseCode '${courseCode}' .
                ?course :courseOf ?class .
                ?student :attendsClass ?class .
                ?student :choosesPollOption ?option .
                ?student foaf:firstName ?firstName .
                ?student foaf:familyName ?lastName .
            }
            GROUP BY ?student ?firstName ?lastName
        }
        BIND((?attendance*5 + ?votes) AS ?activity)
    }
    `,
    getPollResults: (courseCode) => `
    SELECT ?poll ?question ?polloption ?text (COUNT(*) AS ?votecount) 
    WHERE {
        ?course :courseCode '${courseCode}' .
        ?course :courseOf ?class .
        ?class :hostedInClassroom ?classroom.
        ?classroom :hasPoll ?poll .
        ?poll :hasPollOption ?polloption .
        ?polloption :pollOptionChosenBy ?student .
        ?polloption :pollOptionText ?text .
        ?poll :pollQuestion ?question . 
    }
    GROUP BY ?polloption ?poll ?question ?text
    `,
    bestBuddies: () => `
    SELECT ?teacherFirstName ?teacherLastName ?studentFirstName ?studentLastName ?encounters
    WHERE {
        {
            SELECT ?teacherFirstName ?teacherLastName ?studentFirstName ?studentLastName (COUNT(*) AS ?encounters)
            WHERE {
                ?class :classTaughtBy ?teacher.
                ?student :attendsClass ?class.
                ?student foaf:firstName ?studentFirstName.
                ?teacher foaf:firstName ?teacherFirstName.
                ?student foaf:familyName ?studentLastName .
                ?teacher foaf:familyName ?teacherLastName .
            }
            GROUP BY ?teacherFirstName ?teacherLastName ?studentFirstName ?studentLastName
        } FILTER(?encounters = ?maxencounters) {
            SELECT (MAX(?encounters2) AS ?maxencounters)
            WHERE {
                {
                    SELECT ?teacher ?student (COUNT(*) AS ?encounters2)
                    WHERE {
                        ?class :classTaughtBy ?teacher.
                        ?student :attendsClass ?class.
                    }
                    GROUP BY ?teacher ?student
                }
            }
        }
    }
    `,

}

const encoder = (query, args = []) => {
    body = queries[query](...args).trim();
    ns = namespaces.trim();
    return encodeURIComponent(ns + "\n" + body);
}