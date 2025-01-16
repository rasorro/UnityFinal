import os
import subprocess

# Function to create a thumbnail for a given mp4 file
def generate_thumbnail(mp4_file, output_folder, timestamp="00:00:10"):
    # Create the output filename
    file_name = os.path.splitext(os.path.basename(mp4_file))[0] + ".jpg"
    output_path = os.path.join(output_folder, file_name)
    
    # FFmpeg command to extract the thumbnail
    command = [
        "ffmpeg",
        "-i", mp4_file,      # input file
        "-ss", timestamp,    # timestamp of the frame (e.g., 10 seconds in)
        "-vframes", "1",     # capture only 1 frame
        output_path          # output image file
    ]
    
    try:
        subprocess.run(command, check=True)
        print(f"Thumbnail generated for {mp4_file} at {output_path}")
    except subprocess.CalledProcessError as e:
        print(f"Error generating thumbnail for {mp4_file}: {e}")

# Function to process all mp4 files in a folder
def process_folder(folder_path, output_folder, timestamp="00:00:10"):
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    for root, dirs, files in os.walk(folder_path):
        for file in files:
            if file.endswith(".mp4"):
                mp4_file = os.path.join(root, file)
                generate_thumbnail(mp4_file, output_folder, timestamp)

# Main function to process multiple folders
def main(folders, output_folder_base="thumbnails", timestamp="00:00:10"):
    for folder in folders:
        output_folder = os.path.join(output_folder_base, os.path.basename(folder))
        process_folder(folder, output_folder, timestamp)

if __name__ == "__main__":
    # Specify the folders you want to process
    folders_to_process = [
        "Blimp",
        "Eruption",
        "Flowing Lava",
	"Volcano Lighting"
    ]
    
    # Run the script
    main(folders_to_process)
