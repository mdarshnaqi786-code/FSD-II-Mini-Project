
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.time.LocalDate" %>

<%
    String contextPath = request.getContextPath();

    if (session.getAttribute("user") == null
            || !"ORGANIZER".equals(session.getAttribute("role"))
            || !(session.getAttribute("userId") instanceof Integer)) {
        response.sendRedirect(contextPath + "/login.jsp");
        return;
    }

    String error = request.getParameter("error");
    String today = LocalDate.now().toString();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="theme-color" content="#F4EEE1">
    <title>Create Event | CEMS</title>

    <link rel="stylesheet" href="<%= contextPath %>/css/style.css">
</head>

<body class="organizer-dashboard-page">

<header class="site-header">
    <div class="header-inner">
        <a class="brand" href="<%= contextPath %>/organizer-dashboard.jsp">
            <span class="brand-mark">C</span>
            <span>CEMS</span>
        </a>

        <nav class="nav-links" aria-label="Main navigation">
            <a href="<%= contextPath %>/organizer-dashboard.jsp">Dashboard</a>
            <a href="<%= contextPath %>/events">Events</a>
            <a href="<%= contextPath %>/logout">Logout</a>
        </nav>
    </div>
</header>

<main class="organizer-page">

    <section class="organizer-hero">
        <div class="organizer-eyebrow">ORGANIZER WORKSPACE</div>
        <h1>Create your <span>next event.</span></h1>
        <p>
            Enter the event details carefully. Your event will be saved
            and made available to students after successful creation.
        </p>
    </section>

    <section class="organizer-section">

        <div class="organizer-section-heading">
            <span class="section-kicker">NEW EVENT</span>
            <h2>Event details</h2>
            <p>Fields marked * are required.</p>
        </div>

        <% if ("required".equals(error)) { %>
            <p class="message" role="alert">
                Please complete all required fields.
            </p>
        <% } else if ("invalid".equals(error)) { %>
            <p class="message" role="alert">
                Check the dates, times, and participant capacity.
                The event date cannot be in the past, the deadline
                cannot be after the event date, and the end time
                must be later than the start time.
            </p>
        <% } else if ("database".equals(error)) { %>
            <p class="message" role="alert">
                The event could not be saved. Please try again.
            </p>
        <% } %>

        <form action="<%= contextPath %>/create-event"
              method="post"
              class="organizer-card">

            <div class="filter-field">
                <label class="filter-label" for="title">Event title *</label>
                <input id="title" name="title" type="text"
                       maxlength="150" required>
            </div>

            <div class="filter-field">
                <label class="filter-label" for="category">Category *</label>
                <select id="category" name="category" required>
                    <option value="">Select a category</option>
                    <option value="Technical">Technical</option>
                    <option value="Cultural">Cultural</option>
                    <option value="Sports">Sports</option>
                    <option value="Workshop">Workshop</option>
                    <option value="Seminar">Seminar</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <div class="filter-field">
                <label class="filter-label" for="description">
                    Description *
                </label>
                <textarea id="description" name="description"
                          rows="5" maxlength="5000" required></textarea>
            </div>

            <div class="filter-field">
                <label class="filter-label" for="venue">Venue *</label>
                <input id="venue" name="venue" type="text"
                       maxlength="255" required>
            </div>

            <div class="filter-field">
                <label class="filter-label" for="eventDate">
                    Event date *
                </label>
                <input id="eventDate" name="eventDate" type="date"
                       min="<%= today %>" required>
            </div>

            <div class="filter-field">
                <label class="filter-label" for="registrationDeadline">
                    Registration deadline *
                </label>
                <input id="registrationDeadline"
                       name="registrationDeadline" type="date"
                       min="<%= today %>" required>
            </div>

            <div class="filter-field">
                <label class="filter-label" for="startTime">
                    Start time *
                </label>
                <input id="startTime" name="startTime" type="time" required>
            </div>

            <div class="filter-field">
                <label class="filter-label" for="endTime">
                    End time *
                </label>
                <input id="endTime" name="endTime" type="time" required>
            </div>

            <div class="filter-field">
                <label class="filter-label" for="maxParticipants">
                    Maximum participants *
                </label>
                <input id="maxParticipants" name="maxParticipants"
                       type="number" min="1" max="100000" required>
            </div>

            <div class="filter-field">
                <label class="filter-label" for="poster">
                    Poster image URL (optional)
                </label>
                <input id="poster" name="poster" type="url"
                       maxlength="1000"
                       placeholder="https://example.com/event-poster.jpg">
            </div>

            <div class="organizer-hero-actions">
                <button class="btn" type="submit">
                    Create Event
                </button>

                <a class="btn btn-outline"
                   href="<%= contextPath %>/organizer-dashboard.jsp">
                    Cancel
                </a>
            </div>

        </form>

    </section>

    <footer class="organizer-footer">
        &copy; 2026 College Event Management System.
    </footer>

</main>

<script>
    const eventDate = document.getElementById("eventDate");
    const deadline = document.getElementById("registrationDeadline");

    eventDate.addEventListener("change", function () {
        deadline.max = eventDate.value;

        if (deadline.value && deadline.value > eventDate.value) {
            deadline.value = eventDate.value;
        }
    });

    deadline.addEventListener("change", function () {
        if (eventDate.value) {
            deadline.max = eventDate.value;
        }
    });
</script>

</body>
</html>
