flowchart TD
    %% Styling individual nodes
    style A fill:#f9f,stroke:#333,stroke-width:2px
    style B fill:#ccf,stroke:#333,stroke-width:2px
    style C fill:#cfc,stroke:#333,stroke-width:2px
    style D fill:#fcf,stroke:#333,stroke-width:2px
    style E fill:#cff,stroke:#333,stroke-width:2px
    style F fill:#fdf,stroke:#333,stroke-width:2px
    style G fill:#cfc,stroke:#333,stroke-width:2px
    style H fill:#ccf,stroke:#333,stroke-width:2px
    style I fill:#f9f,stroke:#333,stroke-width:2px
    style J fill:#fcc,stroke:#333,stroke-width:2px
    style K fill:#fcf,stroke:#333,stroke-width:2px
    style L fill:#cfc,stroke:#333,stroke-width:2px
    style M fill:#fcc,stroke:#333,stroke-width:2px
    style N fill:#ccf,stroke:#333,stroke-width:2px
    style O fill:#cfc,stroke:#333,stroke-width:2px
    
    %% Defining edges
    A -->|Initialize Variables| B
    B -->|minutes_in_front = 5| C
    C -->|days_in_front = 7| D
    D -->|loop_count = 24| E
    E -->|Generate Random Server Name| F
    F -->|Calculate Scheduled Update Time| G
    G -->|Current Time + 7 Days + minutes_in_front| H
    H -->|Format as YYYY-MM-DD HH:MM:00| I
    I -->|Print Scheduled Time| J
    J -->|Execute MySQL INSERT Query| K
    K -->|Check MySQL Execution| L
    K -->|Check MySQL Execution| M
    L -->|Success| N
    M -->|Failure| N
    N -->|Next Iteration| E
    E -->|After 24 Iterations| O
