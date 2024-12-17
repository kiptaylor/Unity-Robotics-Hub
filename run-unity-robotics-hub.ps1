# PowerShell script to build and run the Unity Robotics container

# Define variables
$imageName = "unity-robotics:pick-and-place"
$dockerfilePath = "docker/Dockerfile"
$containerPort = "10000"
$projectPath = "tutorials\pick_and_place"

# Step 1: Change to the project directory
Write-Host "Changing directory to $projectPath..." -ForegroundColor Cyan
if (Test-Path $projectPath) {
    Set-Location $projectPath
} else {
    Write-Error "Directory $projectPath not found. Exiting..."
    exit 1
}

# Step 2: Build the Docker image
Write-Host "Building the Docker image..." -ForegroundColor Cyan
docker build -t $imageName -f $dockerfilePath .
if ($LASTEXITCODE -ne 0) {
    Write-Error "Docker build failed. Exiting..."
    exit 1
}

# Step 3: Run the Docker container interactively
Write-Host "Running the Docker container..." -ForegroundColor Cyan
docker run -it --rm -p ${containerPort}:${containerPort} $imageName /bin/bash
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to run the Docker container."
    exit 1
}

Write-Host "Docker container exited successfully." -ForegroundColor Green
# after container is up Run the commnad below in bash  leave console window open 
# roslaunch niryo_moveit part_3.launch