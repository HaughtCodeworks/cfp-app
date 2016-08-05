pwd = "userpass"

## Users
admin            = User.create(name: "Admin", email: "an@admin.com", admin: true, password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
organizer        = User.create(name: "Event MC", email: "mc@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
track_director   = User.create(name: "Track Director", email: "track@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
reviewer         = User.create(name: "Reviewer", email: "review@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
speaker_reviewer = User.create(name: "Speak and Review", email: "both@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
speaker_1        = User.create(name: "Speaker1", email: "speak1@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
speaker_2        = User.create(name: "Speaker2", email: "speak2@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
speaker_3        = User.create(name: "Speaker3", email: "speak3@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
speaker_4        = User.create(name: "Speaker4", email: "speak4@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
speaker_5        = User.create(name: "Speaker5", email: "speak5@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)

### SeedConf -- event is in the middle of the CFP
seed_start_date = 8.months.from_now

# Core Event Info
seed_guidelines = %Q[
# SeedConf wants you!

The first annual conference about seed data is happening
in sunny Phoenix, Arizona on December 1st, 2016!

If your talk is about seed data in Rails apps, we want to hear about it!

## #{Faker::Hipster.sentence(4)}
#{Faker::Hipster.paragraph(8)}

#{Faker::Hipster.paragraph(13)}

#{Faker::Hipster.paragraph(6)}
]

seed_event = Event.create(name: "SeedConf",
                          slug: "seedconf",
                          url: "http://nativeseed.info/",
                          contact_email: "info@seed.event",
                          closes_at: 6.months.from_now,
                          state: "open",
                          start_date: seed_start_date,
                          end_date: seed_start_date + 1,
                          guidelines: seed_guidelines,
                          proposal_tags: %w(beginner intermediate advanced),
                          review_tags: %w(beginner intermediate advanced))

# Session Formats
lightning_talk   = seed_event.public_session_formats.create(name: "Lightning Talk", duration: 5, description: "Warp speed! Live your audience breathless and thirsty for more.")
short_session    = seed_event.public_session_formats.create(name: "Short Talk", duration: 40, description: "Kinda short! Talk fast. Talk hard.")
long_session     = seed_event.public_session_formats.create(name: "Long Talk", duration: 120, description: "Longer talk allows a speaker put more space in between words, hand motions.")
internal_session = seed_event.session_formats.create(name: "Beenote", public: false, duration: 180, description: "Involves live bees.")

# Tracks
track_1 = seed_event.tracks.create(name: "Best Track", description: "Better than all the other tracks.", guidelines: "Watch yourself. Watch everybody else. All of us are winners in the best track.")
track_2 = seed_event.tracks.create(name: "OK Track", description: "This track is okay.", guidelines: "Mediocrity breeds mediocrity. Let's talk about how to transcend the status quo.")
track_3 = seed_event.tracks.create(name: "Boring Track", description: "Great if you want a nap!", guidelines: "Sleep deprivation is linked to many health problem. Get healthy here so you can be 100% for the Best Track.")

# Rooms
seed_event.rooms.create(name: "Sun Room", room_number: "SUN", level: "12", address: "123 Universe Drive", capacity: 300, event_id: seed_event.id)
seed_event.rooms.create(name: "Moon Room", room_number: "MOON", level: "6", address: "123 Universe Drive", capacity: 150, event_id: seed_event.id)
seed_event.rooms.create(name: "Venus Theater", room_number: "VEN-T", level: "2", address: "123 Universe Drive", capacity: 75, event_id: seed_event.id)

# Event Team
seed_event.teammates.create(user: organizer, email: organizer.email, role: "organizer", state: Teammate::ACCEPTED, notifications: false)
seed_event.teammates.create(user: track_director, email: track_director.email, role: "program team", state: Teammate::ACCEPTED)
seed_event.teammates.create(user: reviewer, email: reviewer.email, role: "reviewer", state: Teammate::ACCEPTED)
seed_event.teammates.create(user: speaker_reviewer, email: speaker_reviewer.email, role: "reviewer", state: Teammate::ACCEPTED)

# Proposals - there are no proposals that are either fully "accepted" or offically "not accepted"
submitted_proposal_1 = seed_event.proposals.create(event_id: seed_event.id,
                                                   uuid: "abc123",
                                                   title: "Honey Bees",
                                                   abstract: "We will discuss the vital importance of pollinators and how we can help them thrive.",
                                                   details: "Why we need pollinators, what plants they love most, basics of how to start your own hive.",
                                                   pitch: "Learning to be stewards for our insect friends is essential to keeping some of our favorite foods around!",
                                                   session_format_id: long_session.id,
                                                   track_id: track_1.id)

submitted_proposal_2 = seed_event.proposals.create(event_id: seed_event.id,
                                                   uuid: "def456",
                                                   title: "Coffee Talk",
                                                   abstract: "We go over what makes a great cup of coffee as well as different methods of preparation.",
                                                   details: "We will talk about the coffee plant itself, the roasting process, and prepare the same beans in a variety of different ways to compare the flavor and nuances.",
                                                   pitch: "You need coffee to live happily, why not be drinking the best tasting versions of your favorite drug?",
                                                   session_format_id: long_session.id,
                                                   track_id: track_2.id)

waitlisted_proposal = seed_event.proposals.create(event_id: seed_event.id,
                                                  state: "waitlisted",
                                                  uuid: "jkl012",
                                                  title: "Javascript for Dummies",
                                                  abstract: "This talk is a basic introduction to Javascript and how to use it effectively.",
                                                  details: "Discussion will include a bit about the history of JS and some high level topics. From there we will learn enough basics to build a simple game together!",
                                                  pitch: "You + Javascript = Besties for Life!!",
                                                  session_format_id: short_session.id,
                                                  track_id: track_3.id)

soft_accepted_proposal = seed_event.proposals.create(event_id: seed_event.id,
                                                     state: "soft accepted",
                                                     uuid: "mno345",
                                                     title: "Vegan Ice Cream",
                                                     abstract: "This is a hands on class where we will make some delicious dairy-and-egg-free concoctions!",
                                                     details: "Participants will learn the basics of how to make a healthy animal-free ice cream as well as how to come up with amazing flavor combinations.",
                                                     pitch: "Who doesn't love ice cream?",
                                                     session_format_id: internal_session.id,
                                                     track_id: track_1.id)

soft_rejected_proposal = seed_event.proposals.create(event_id: seed_event.id,
                                                     state: "soft rejected",
                                                     uuid: "xyz999",
                                                     title: "DIY Unicorn Hat in 30 minutes",
                                                     abstract: "You need to keep your head warm, why not do it with style?",
                                                     details: "It's arts and crafts time! Learn how to make the hat of your dreams with the things already lying around your house.",
                                                     pitch: "Have you really lived this long without a unicorn hat?",
                                                     session_format_id: short_session.id,
                                                     track_id: track_2.id)

withdrawn_proposal = seed_event.proposals.create(event_id: seed_event.id,
                                                 state: "withdrawn",
                                                 uuid: "pqr678",
                                                 title: "Mystical Vortices",
                                                 abstract: "Learn spiritual energy technics to help cure what ails you.",
                                                 details: "We will enter into the portable vortex I carry in my bag at all times and explore the realms of the unreal.",
                                                 pitch: "Uh, I said VORTICES - what more motivation for coming do you need??",
                                                 session_format_id: lightning_talk.id,
                                                 track_id: track_1.id)

# Speakers
submitted_proposal_1.speakers.create(speaker_name: speaker_1.name, speaker_email: speaker_1.email, bio: "I am a speaker for cool events!", user_id: speaker_1.id, event_id: seed_event.id)
submitted_proposal_1.speakers.create(speaker_name: speaker_2.name, speaker_email: speaker_2.email, bio: "I know a little bit about everything.", user_id: speaker_2.id, event_id: seed_event.id)
submitted_proposal_2.speakers.create(speaker_name: speaker_2.name, speaker_email: speaker_2.email, bio: "I know a little bit about everything.", user_id: speaker_2.id, event_id: seed_event.id)
soft_accepted_proposal.speakers.create(speaker_name: speaker_3.name, speaker_email: speaker_3.email, bio: "I am the best speaker in the entire world!", user_id: speaker_3.id, event_id: seed_event.id)
waitlisted_proposal.speakers.create(speaker_name: speaker_4.name, speaker_email: speaker_4.email, bio: "I specialize in teaching cutting edge programming techniques to beginners.", user_id: speaker_4.id, event_id: seed_event.id)
soft_rejected_proposal.speakers.create(speaker_name: speaker_5.name, speaker_email: speaker_5.email, bio: "I like cookies and rainbows.", user_id: speaker_5.id, event_id: seed_event.id)
withdrawn_proposal.speakers.create(speaker_name: speaker_3.name, speaker_email: speaker_3.email, bio: "I am the best speaker in the entire world!", user_id: speaker_3.id, event_id: seed_event.id)

# Proposal Tags
submitted_proposal_1.taggings.create(proposal_id: submitted_proposal_1.id, tag: "intermediate")
submitted_proposal_2.taggings.create(proposal_id: submitted_proposal_2.id, tag: "intermediate")
waitlisted_proposal.taggings.create(proposal_id: waitlisted_proposal.id, tag: "beginner")
soft_accepted_proposal.taggings.create(proposal_id: soft_accepted_proposal.id, tag: "beginner")
soft_rejected_proposal.taggings.create(proposal_id: soft_rejected_proposal.id, tag: "beginner")
withdrawn_proposal.taggings.create(proposal_id: withdrawn_proposal.id, tag: "advanced")

# Reviewer Tags
submitted_proposal_1.taggings.create(proposal_id: submitted_proposal_1.id, tag: "beginner", internal: true)
submitted_proposal_2.taggings.create(proposal_id: submitted_proposal_2.id, tag: "beginner", internal: true)
waitlisted_proposal.taggings.create(proposal_id: waitlisted_proposal.id, tag: "beginner", internal: true)
soft_accepted_proposal.taggings.create(proposal_id: soft_accepted_proposal.id, tag: "beginner", internal: true)
soft_rejected_proposal.taggings.create(proposal_id: soft_rejected_proposal.id, tag: "intermediate", internal: true)
withdrawn_proposal.taggings.create(proposal_id: withdrawn_proposal.id, tag: "advanced", internal: true)

# Ratings
submitted_proposal_1.ratings.create(proposal_id: submitted_proposal_1.id, user_id: organizer.id, score: 4)
submitted_proposal_1.ratings.create(proposal_id: submitted_proposal_1.id, user_id: reviewer.id, score: 3)
submitted_proposal_1.ratings.create(proposal_id: submitted_proposal_1.id, user_id: track_director.id, score: 5)

submitted_proposal_2.ratings.create(proposal_id: submitted_proposal_2.id, user_id: organizer.id, score: 4)
submitted_proposal_2.ratings.create(proposal_id: submitted_proposal_2.id, user_id: speaker_reviewer.id, score: 2)

waitlisted_proposal.ratings.create(proposal_id: waitlisted_proposal.id, user_id: track_director.id, score: 3)
waitlisted_proposal.ratings.create(proposal_id: waitlisted_proposal.id, user_id: organizer.id, score: 3)

soft_accepted_proposal.ratings.create(proposal_id: soft_accepted_proposal.id, user_id: organizer.id, score: 4)
soft_accepted_proposal.ratings.create(proposal_id: soft_accepted_proposal.id, user_id: reviewer.id, score: 3)
soft_accepted_proposal.ratings.create(proposal_id: soft_accepted_proposal.id, user_id: track_director.id, score: 4)
soft_accepted_proposal.ratings.create(proposal_id: soft_accepted_proposal.id, user_id: speaker_reviewer.id, score: 5)

soft_rejected_proposal.ratings.create(proposal_id: soft_rejected_proposal.id, user_id: organizer.id, score: 1)
soft_rejected_proposal.ratings.create(proposal_id: soft_rejected_proposal.id, user_id: reviewer.id, score: 3)
soft_rejected_proposal.ratings.create(proposal_id: soft_rejected_proposal.id, user_id: track_director.id, score: 1)
soft_rejected_proposal.ratings.create(proposal_id: soft_rejected_proposal.id, user_id: speaker_reviewer.id, score: 2)

withdrawn_proposal.ratings.create(proposal_id: withdrawn_proposal.id, user_id: organizer.id, score: 5)
withdrawn_proposal.ratings.create(proposal_id: withdrawn_proposal.id, user_id: reviewer.id, score: 5)
withdrawn_proposal.ratings.create(proposal_id: withdrawn_proposal.id, user_id: speaker_reviewer.id, score: 4)

# Comments
organizer.comments.create(proposal_id: submitted_proposal_1.id,
                          user_id: organizer.id,
                          body: "This looks great - very informative. Great job!",
                          type: "PublicComment")

reviewer.comments.create(proposal_id: soft_accepted_proposal.id,
                         user_id: reviewer.id,
                         body: "Oh my goodness, this looks so fun!",
                         type: "PublicComment")

track_director.comments.create(proposal_id: soft_accepted_proposal.id,
                               user_id: track_director.id,
                               body: "Cleary we should accept this talk.",
                               type: "InternalComment")

speaker_reviewer.comments.create(proposal_id: withdrawn_proposal.id,
                                 user_id: speaker_reviewer.id,
                                 body: "Uhhhh... is this for real? I can't decide if this is amazing or insane.",
                                 type: "InternalComment")


### SapphireConf -- this is an event in the early set-up/draft stage
sapphire_start_date = 10.months.from_now

# Core Event Info
sapphire_guidelines = %Q[
# SapphireConf - The place to be in 2017!

The first annual conference about the hot new programming language Sapphire
is happening in moody Reykjavík, Iceland on February 1st, 2017!

If you are on the cutting edge with savvy Sapphire skills, we want you!

## #{Faker::Hipster.sentence(4)}
#{Faker::Hipster.paragraph(20)}
]

sapphire_event = Event.create(name: "SapphireConf",
                              slug: "sapphireconf",
                              url: "https://en.wikipedia.org/wiki/Sapphire",
                              contact_email: "info@sapphire.event",
                              start_date: sapphire_start_date,
                              end_date: sapphire_start_date + 1,
                              guidelines: sapphire_guidelines,
                              proposal_tags: %w(beginner intermediate advanced),
                              review_tags: %w(beginner intermediate advanced))

# Event Team
sapphire_event.teammates.create(user: organizer, email: organizer.email, role: "organizer", state: Teammate::ACCEPTED)
