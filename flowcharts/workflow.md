flowchart TD
    A(Start) --> B{Initialize Variables}
    B --> |minutes_in_front = 5| C
    C --> |days_in_front = 7| D
    D --> |loop_count = 24| E{Loop i = 1 to 24}
    
    E --> |Generate Random Server Name| F[Random serverX.boschsg]
    F --> G[Calculate Scheduled Update Time]
    G --> |Current Time + 7 Days + minutes_in_front| H[Format as YYYY-MM-DD HH:MM:00]
    H --> I[Print Scheduled Time]

    I --> J[Execute MySQL INSERT Query]
    J --> |INSERT INTO patching.patch| K{Check MySQL Execution}

    K --> |Success| L[Print Patch Scheduled]
    K --> |Failure| M[Print Error Scheduling]

    L --> N[Increment minutes_in_front by 5]
    M --> N

    N --> |Next Iteration| E
    E -->|After 24 Iterations| O(End)
