import time
from termcolor import colored, cprint
import sys
import json
from rubik.cube import Cube
from rubik_solver import utils
import requests
Cube_State = ''
RAM_Solution = ''
#     GWB
#     GYB
#     GGY
# WWY RYG OOW RBR
# OBO GRR YGR GOW
# OBO WOO BBB YRB
#     GYW
#     RWY
#     YWR


def listTOstring(input):
    output = ""
    for ele in input:
        output += ele.raw + " "
    return(output)

print("Hi there");
while(True):
    SOLVING_TEXT = colored('Solving...................  ',
                           'red', attrs=['reverse'])
    time.sleep(0.2)
    response = requests.get("http://localhost:3000/data")
# -----------------------------------------Get_Value_for_Server-----------------------------------------------
    SolverID = (json.loads(response.text)["SolverID"])

#     >>> utils.solve(cube, 'Beginner')
# [F', R, U', R', U, U, F2, Y, B', U, B, U, F2, Y, R', F', U, F, R, U, U, U, F2, Y, L, F, U', F', L', U, F2, Y, L', U, L, U', R, U, R', Y, U', F', U', F, Y, B, U, B', R, U, R', Y, Y, U', L', U, L, U, F, U', F', Y, Y, U2, Y2, U, R, U', R', U', F', U, F, Y, Y, U, R, U', R', U', F', U, F, Y, F, R, U, R', U', F', U2, F, R, U, R', U', F', F, R, U, R', U', F', U, U, U, U, R, U', L', U, R', U', L, R', D', R, D, R', D', R, D, U, R', D', R, D, R', D', R, D, U, U, R', D', R, D, R', D', R, D, U]
# >>> utils.solve(cube, 'CFOP')
# [F', R, U', R', U, U, F2, Y, B', U, B, U, F2, Y, R', F', U, F, R, U, U, U, F2, Y, L, F, U', F', L', U, F2, Y, L', U, L, U', U, F', U, F, U, F', U2, F, Y, U, Y', R', U', R, U2, R', U', R, U, R', U', R, Y, Y, B, U, B', U, F', U2, F, U, F', U2, F, Y, U2, U', R, U, R', U, R, U, R', Y, Y, R', F, R, U, R', F', R, Y, L, U', L', U, Y, Y, Y, Y, U, Y, Y, Y, Y, U, Y, Y, R, U', R, U, R, U, R, U', R', U', R2]
# >>> utils.solve(cube, 'Kociemba')
# [L', F, B2, R', B, R', L, B, D', F', U, B2, U, F2, D', R2, L2, U, F2, D']

# -----------------------------------------Get_Value_for_Server-----------------------------------------------
    if(SolverID == "2"):
        Cube_State = (json.loads(response.text)["Cube_State_Python"])
    else:
        Cube_State = ""
# CFOP Beginner Kociemba
    if(SolverID == "2" and len(Cube_State) == 54):
        print(SOLVING_TEXT)
        RAM_Solution = listTOstring(utils.solve(Cube_State, 'Kociemba'))
        data = {
            "Cube_Solution": RAM_Solution,
            "SolverID": "3"
        }
        requests.patch("http://localhost:3000/data", data=data)
        text = colored('Get_Solution:', 'red', attrs=['reverse', 'blink'])
        print("------------------------------------------------------------------------")
        print("------------------------------------------------------------------------")
        print("||                                                                    ||")
        print("||                                                                    ||")
        print("||                                                                    ||")
        print("||                                                                    ||")
        print("||                                                                    ||")
        print("||                                                                    ||")
        print("||                                                                    ||")
        print("||                                                                    ||")
        print("||"+text+"   " + RAM_Solution+"||")
        print("||                                                                    ||")
        print("||                                                                    ||")
        print("||                                                                    ||")
        print("||                                                                    ||")
        print("||                                                                    ||")
        print("||                                                                    ||")
        print("||                                                                    ||")
        print("||                                                                    ||")
        print("------------------------------------------------------------------------")
        print("------------------------------------------------------------------------")
        time.sleep(3)

