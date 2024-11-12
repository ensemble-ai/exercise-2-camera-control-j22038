# Code Review for Programming Exercise 1 #
## Description ##

For this assignment, you will be giving feedback on the completeness of Exercise 1.  To do so, we will be giving you a rubric to provide feedback on. For the feedback, please provide positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to review the code and project files that were given out by the instructor.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.

## Due Date and Submission Information ##
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer-review. The file name should be the same as in the template: PeerReview-Exercise1.md. You also need to include your name and email address in the Peer-reviewer Information section below. This review document should be placed into the base folder of the repo you are reviewing in the master branch. This branch should be on the origin of the repository you are reviewing.

If you are in the rare situation where there are two peer-reviewers on a single repository, append your UC Davis user name before the extension of your review file. An example: PeerReview-Exercise1-username.md. Both reviewers should submit their reviews in the master branch.  

## Solution Assessment ##

## Peer-reviewer Information

* *name:* Ethan Nguyen
* *email:* etng@ucdavis.edu

### Description ###

To assess the solution, you will be choosing ONE choice from unsatisfactory, satisfactory, good, great, or perfect. Place an x character inside of the square braces next to the appropriate label.

The following are the criteria by which you should assess your peer's solution of the exercise's stages.

#### Perfect #### 
    Cannot find any flaws concerning the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    A major flaw and some minor flaws.

#### Satisfactory ####
    A couple of major flaws. Heading towards a solution, however, did not fully realize the solution.

#### Unsatisfactory ####
    Partial work, but not really converging to a solution. Pervasive major flaws. Objective largely unmet.


### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
Position Lock works just as intended the vessel and camera are locked into place based on inputs

### Stage 2 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
Auto scroll works as intended however the player/vessel is not being pushed forward by the box as it just stays in place during the autoscroll.

### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 
The cross follows behind the vessel as intended, position lock and lerp is working.

### Stage 4 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 
The cross follows ahead of the vessel as intended, lerping target focus is working.

### Stage 5 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 
Speedup push zone works as intended, speedup zone moves the camera, and moving in the inner box works as well. 

## Code Style ##

### Description ###

### Code Style Review ###
The student does a great job following the guidelines for the most part and is able to keep lines nicely formated. 
#### Style Guide Infractions ####
There were no infractions from what I reviewed. Coding style looks well organized and followd godot's handbook

#### Style Guide Exemplars ####
Good use of intentions (here)[https://github.com/ensemble-ai/exercise-2-camera-control-j22038/blob/168480931280ebea0a964c164fb4ae87cfcecbc8/Obscura/scripts/camera_controllers/lerp_target.gd#L23]. According to the guidelines, if statments should be on the same line as their executions, so this is a good exeplar.

## Best Practices ##

### Description ###

### Best Practices Review ###
The student has followed the guidelines well such as indentations and putting variables right before lines of execution, using said variables. 

#### Best Practices Infractions ####
Student seems to be following many best practices, after reviewing, I could not find an infraction of best practices. 

#### Best Practices Exemplars ####
Student does well of ordering lines of (code)[https://github.com/ensemble-ai/exercise-2-camera-control-j22038/blob/168480931280ebea0a964c164fb4ae87cfcecbc8/Obscura/scripts/camera_controllers/lerp_target.gd#L7] such as putting the constants above the exports. 