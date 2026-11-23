# Record a short demo

The [video slides](release/fisheries-video-deck.pptx) have six slides. The
speaker notes contain the script below.

## Record in PowerPoint

1. Open the video slides in PowerPoint. Save a personal copy outside the
   project folder before adding your voice.
2. Select **Record > From Beginning** and turn on your microphone. Under
   **Views**, choose **Teleprompter** to see the notes.
3. Read the notes and advance through the six slides. Pause when changing
   slides; PowerPoint does not record audio during transitions.
4. Stop recording. Select **File > Export > Create a Video**, choose **Use
   Recorded Timings and Narrations**, and save as MP4.
5. Watch the video once. Follow the organizers' instructions for length,
   format and submission.

The demo slide shows output from a real **scripted** MCP run, not a live AI
answer. If the organizers require a live demonstration, use an approved screen
recorder and run this command from the project folder:

```powershell
.\.venv\Scripts\python.exe submission\demo.py
```

With `uv`, use `uv run python submission\demo.py` instead.

## Script

**1. The problem**

> Fisheries scientists need clear access to survey data. Our prototype helps
> an AI assistant look up public NOAA data without exposing a private database.

**2. The solution**

> Five read-only tools find species, summarize and compare catch, check
> coverage, and provide selected NOAA report context. The data cover cod and
> haddock from 2021 through 2025.

**3. The demo**

> This slide shows a scripted demonstration using the real MCP server, not a
> live AI answer. It looks up cod and shows catch and coverage for 2022 and
> 2023. Weight units are unspecified. The survey changed in 2023, so we cannot
> say from these totals alone why catch differed.

**4. Results**

> In a separate AI test, 80 of 80 tool calls in 45 main trials returned without
> an error. Successful retrieval is not the same as a trustworthy explanation.

**5. What we learned**

> A partial AI-assisted review found 8 answers with unsupported claims.
> The other 37 are unverified, not passes. Scientists still need to review
> the interpretations.

**6. The takeaway**

> This is a public-data prototype, not an official assessment. It makes
> fisheries data easier to retrieve while keeping scientists in the loop.
> No scientific approval is claimed.
